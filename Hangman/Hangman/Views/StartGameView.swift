//
//  StartGameview.swift
//  GuessTheSong
//
//  Created by Sebastian Maier on 02.02.24.
//

import SwiftUI

struct StartGameView: View {
    @AppStorage("highscore") var highscore: Double = 0
    @AppStorage("streak") var streak: Double = 0
    @AppStorage("customHighscore") var customHighscore: Double = 0
    @AppStorage("customStreak") var customStreak: Double = 0
    
    @State var showInfo: Bool = false
    @State var customMode: Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    
    let categories: [Category] = Category.allCases
    @State var playCategories: [String] = Category.allCasesSingular
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Stats")
                        .font(.largeTitle)
                        .foregroundStyle(.BWL)
                        .bold()
                        .padding(.leading, 10)
                        .transition(.scale)
                    
                    Spacer()
                }
                
                HStack {
                    Group {
                        VStack {
                            Text("Longest Streak")
                            
                            Text(customMode ? "\(String(format: "%.0f", customStreak))" : "\(String(format: "%.0f", streak))")
                        }
                        
                        VStack {
                            Text("Highest points")
                            
                            Text(customMode ? "\(String(format: "%.0f", customHighscore))": "\(String(format: "%.0f", highscore))")
                        }
                    }
                    .padding()
                    .font(.title2)
                    .foregroundStyle(.BWL)
                    .frame(maxWidth: .infinity)
                    .background(.gray.opacity(0.3))
                    .clipShape(.rect(cornerRadius: 20))
                }
                
                Spacer()
            }
            
            VStack {
                Spacer(minLength: 200)
                
                HStack {
                    Toggle(isOn: $customMode){
                        Text("Custom mode")
                            .font(.largeTitle)
                            .foregroundStyle(.BWL)
                            .bold()
                            .padding(.leading, 10)
                    }
                    .padding(.trailing, 10)
                    .tint(.correct)
                }
                
                Spacer(minLength: 20)
                
                ScrollViewReader { scrollView in
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 2), spacing: 16) {
                            ForEach(categories.indices, id: \.self) { index in
                                let category = categories[index]
                                let isLeftElement = index % 2 == 0 // Überprüfe, ob der Index gerade ist, um das linke Element zu identifizieren
                                CategoryView(text: category, categoriesEnabled: $customMode, selectedCategories: $playCategories, left: isLeftElement)
                                    .id(category)
                            }
                        }
                        Spacer(minLength: 150)
                    }
                    .onChange(of: customMode) {
                        if !customMode {
                            withAnimation {
                                if let firstCategory = categories.first {
                                    scrollView.scrollTo(firstCategory, anchor: .top)
                                }
                            }
                            playCategories = Category.allCasesSingular
                        } else {
                            playCategories = []
                        }
                        print(playCategories)
                    }
                    .opacity(customMode ? 1 : 0.3)
                    .disabled(!customMode)
                }
            }
            
            
            
            VStack {
                Spacer()
                
                NavigationLink{
                    PlayController(categories: $playCategories, customMode: customMode)
                } label: {
                    ButtonView(text: "Start")
                        .padding(.bottom, 30)
                }
            }
        }
        .padding(.horizontal)
        .navigationBarBackButtonHidden(true)
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("\(Image(systemName: "chevron.left"))")
                        .fontWeight(.bold)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showInfo.toggle()
                } label: {
                    Image(systemName: "info.circle")
                }
                
                .fullScreenCover(isPresented: $showInfo, content: {
                    RulesSheetView(showInfo: $showInfo)
                })
            }
        })
    }
}

#Preview {
    StartGameView()
}
