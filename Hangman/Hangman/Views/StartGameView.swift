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
    @State var nothingSelected: Bool = false
    @State var streakText: Double = 0
    @State var pointsText: Double = 0
    @State var scrollDisabled: Bool = true
    
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
                    
                    Spacer()
                }
                
                HStack {
                    Group {
                        VStack {
                            Text("Longest Streak")
                            
                            Text("\(String(format: "%.0f", streakText))")
                                .contentTransition(.numericText())
                        }
                        
                        VStack {
                            Text("Highest points")
                            
                            Text("\(String(format: "%.0f", pointsText))")
                                .contentTransition(.numericText())
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
            .padding(.horizontal)
            
            VStack {
                Spacer(minLength: 200)
                
                
                Toggle(isOn: $customMode) {
                    Text("Custom mode")
                        .font(.largeTitle)
                        .foregroundStyle(.BWL)
                        .bold()
                        .padding(.leading, 10)
                }
                .onChange(of: customMode) {
                    withAnimation {
                        scrollDisabled.toggle()
                    }
                }
                .padding(.trailing, 10)
                .tint(.correct)
                .padding(.horizontal)
                
                
                Spacer(minLength: 20)
                
                ScrollViewReader { scrollView in
                    ScrollView(showsIndicators: false) {
                        Spacer(minLength: 15)
                            .id("firstSpacer")
                        LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 2), spacing: 16) {
                            ForEach(categories.indices, id: \.self) { index in
                                let category = categories[index]
                                let isLeftElement = index % 2 == 0 // Überprüfe, ob der Index gerade ist, um das linke Element zu identifizieren
                                CategoryView(text: category, categoriesEnabled: $customMode, selectedCategories: $playCategories, left: isLeftElement)
                                    .id(category)
                                    .padding(isLeftElement ? .leading : .trailing)
                            }
                        }
                        Spacer(minLength: 150)
                    }
                    .onChange(of: scrollDisabled) {
                        if scrollDisabled {
                            withAnimation {
                                    scrollView.scrollTo("firstSpacer", anchor: .top)
                            }
                            playCategories = Category.allCasesSingular
                        } else {
                            playCategories = []
                        }
                        print(playCategories)
                    }
                    .opacity(scrollDisabled ? 0.3 : 1)
                    .disabled(scrollDisabled)
                }
            }
            
            VStack {
                Spacer()
                
                NavigationLink{
                    PlayController(categories: $playCategories, customMode: customMode)
                } label: {
                    Text("Start")
                        .font(.title)
                        .bold()
                        .foregroundStyle(.WWL)
                        .padding()
                        .padding(.horizontal, 60)
                        .background(nothingSelected ? .BWL.opacity(0.4) : .correct)
                        .clipShape(.rect(cornerRadius: 20))
                        .shadow(color: .BWL.opacity(nothingSelected ? 0 : 0.2), radius: 10, x: 0, y: 5)
                        .padding(.bottom, 30)
                }
                .disabled(nothingSelected)
                
            }
            .padding(.horizontal)
        }
        .onAppear {
            streakText = streak
            pointsText = highscore
        }
        .onChange(of: customMode) {
            if customMode {
                withAnimation {
                    streakText = customStreak
                    pointsText = customHighscore
                }
            } else {
                withAnimation {
                    streakText = streak
                    pointsText = highscore
                }
            }
        }
        .onChange(of: playCategories) {
            if customMode {
                if playCategories.isEmpty {
                    withAnimation {
                        nothingSelected = true
                    }
                    
                }
                else if nothingSelected == true {
                    withAnimation {
                        nothingSelected = false
                    }
                }
            } else {
                withAnimation {
                    nothingSelected = false
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("\(Image(systemName: "chevron.left.circle"))")
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
