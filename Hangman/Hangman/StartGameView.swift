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
    
    var body: some View {
        VStack {
            ScrollView {
                Spacer()
                
                Text("Stats")
                    .font(.largeTitle)
                    .foregroundStyle(.BWL)
                    .bold()
                
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
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    
                }
                
                Spacer(minLength: 40)
                
                Text("Rules")
                    .font(.largeTitle)
                    .foregroundStyle(.BWL)
                    .bold()
                
                
                Text("In this mode, you'll receive a random English word. Each character you guess brings you either closer to the correct answer or closer to revealing the 'hangman'. Now, aim high and reach for the stars!")
                    .padding()
                    .background(.gray.opacity(0.3))
                    .clipShape(.rect(cornerRadius: 20))
                    .font(.title2)
                    .foregroundColor(.BWL)
                    .multilineTextAlignment(.center)
                
                Spacer(minLength: 40)
                
                Text("Point System")
                    .font(.largeTitle)
                    .foregroundStyle(.BWL)
                    .bold()
                
                
                Text("Starting with 100 points, each incorrect guess deducts 10 points. However, correctly guessing the word propels you to the next round with a 10% point increase. For instance, reaching the second round boosts your starting points to 110.")
                    .padding()
                    .background(.gray.opacity(0.3))
                    .clipShape(.rect(cornerRadius: 20))
                    .font(.title2)
                    .foregroundColor(.BWL)
                    .multilineTextAlignment(.center)
                
                Spacer()
            }
            .onAppear {
                // Nachdem die ScrollView erscheint, die scrollIndicators ausblenden
                UIScrollView.appearance().showsVerticalScrollIndicator = false
                UIScrollView.appearance().showsHorizontalScrollIndicator = false
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            
            
            NavigationLink{
                PlayControllerView()
            } label: {
                Text("Start")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(.semibold)
                    .foregroundStyle(.WWL)
                    .padding()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .background(.BWL)
                    .clipShape(.rect(cornerRadius: 20))
                    .shadow(color: .BWL.opacity(0.5), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y: 5)
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    StartGameView()
}
