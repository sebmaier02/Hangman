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
    
    @State var showInfo: Bool = false
    @State var categoriesEnabled: Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    
    let categories: [Category] = Category.allCases
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Stats")
                        .font(.largeTitle)
                        .foregroundStyle(.BWL)
                        .bold()
                        .padding(.leading, 10)
                    
                    Spacer()
                }
                
                HStack {
                    Group {
                        VStack {
                            Text("Longest Streak")
                            
                            Text("\(String(format: "%.0f", streak))")
                        }
                        
                        VStack {
                            Text("Highest points")
                            
                            Text("\(String(format: "%.0f", highscore))")
                        }
                    }
                    .padding()
                    .font(.title2)
                    .foregroundStyle(.BWL)
                    .background(.gray.opacity(0.3))
                    .clipShape(.rect(cornerRadius: 20))
                    .frame(maxWidth: .infinity)
                }
                
                Spacer()
            }
            
            VStack {
                Spacer(minLength: 200)
                
                HStack {
                    Toggle(isOn: $categoriesEnabled){
                        Text("Categories")
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
                                CategoryView(text: category.rawValue, categoriesEnabled: $categoriesEnabled, left: isLeftElement)
                                    .id(category)
                            }
                        }
                    }
                    .onChange(of: categoriesEnabled) {
                        if !categoriesEnabled {
                            withAnimation {
                                if let firstCategory = categories.first {
                                    scrollView.scrollTo(firstCategory, anchor: .top)
                                }
                            }
                        }
                    }
                    .opacity(categoriesEnabled ? 1 : 0.3)
                    .disabled(!categoriesEnabled)
                }
            }
            
            VStack {
                Spacer()
                
                NavigationLink{
                    PlayController()
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
