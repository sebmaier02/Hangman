//
//  StartGameview.swift
//  GuessTheSong
//
//  Created by Sebastian Maier on 02.02.24.
//

import SwiftUI

struct StartGameView: View {
    var mode: String
    @State var rounds: Int = 0
    var description: String
    @Environment(\.dismiss) var dismiss
    @AppStorage("highscoreQuick") var highscoreQuick: Int = 0
    @AppStorage("highscoreMedium") var highscoreMedium: Int = 0
    @AppStorage("highscoreInfinity") var highscoreInfinity: Int = 0
    
    var body: some View {
        VStack (alignment: .leading) {
            Spacer()
            
            Text("Description")
                .font(.largeTitle)
                .padding(.bottom)
            
            Text(description)
                .font(.title2)
            
            Spacer()
            
            Text("Rules")
                .font(.largeTitle)
                .padding(.bottom)
            
            if mode == "Quick" {
                Group {
                    Text("You play 10 rounds")
                    Text("Title and interpret correct: 100 points")
                    Text("Title ore interpret correct: 50 points")
                    Text("Neither: 0 points")
                }
                .font(.title2)
            } else if mode == "Medium" {
                Group {
                    Text("You play 20 rounds")
                    Text("Title and interpret correct: 100 points")
                    Text("Title ore interpret correct: 50 points")
                    Text("Neither: 0 points")
                }
                .font(.title2)
            } else if mode == "Infinity" {
                Group {
                    Text("There is no round limit!!!!")
                    Text("Title and interpret correct: 100 points")
                    Text("Title ore interpret correct: 50 points")
                    Text("Neither: 0 points and Gameover!")
                }
                .font(.title2)
            }
            
            Spacer()
            
            if mode == "Quick" {
                Text("Highscore: \(highscoreQuick)")
                    .font(.largeTitle)
            } else if mode == "Medium" {
                Text("Highscore: \(highscoreMedium)")
                    .font(.largeTitle)
            } else if mode == "Infinity" {
                Text("Highscore: \(highscoreInfinity)")
                    .font(.largeTitle)
            }
            
            Spacer()
            
            NavigationLink{
                GameView(rounds: rounds)
            } label: {
                Text("Start")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(20)
                    .shadow(color: Color.blue.opacity(0.5), radius: 10, x: 0, y: 5)
            }
            
            Spacer()
        }
        .padding()
        .onAppear {
            if mode == "Quick" {
                rounds = 10
            } else if mode == "Medium" {
                rounds = 20
            } else if mode == "Infinity" {
                rounds = -1
            }
        }
    }
}
#Preview {
    StartGameView(mode: "Infinity", description: "lol")
}
