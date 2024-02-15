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
    @Environment(\.dismiss) var dismiss
    @AppStorage("highscoreQuick") var highscoreQuick: Int = 0
    @AppStorage("highscoreMedium") var highscoreMedium: Int = 0
    @AppStorage("highscoreInfinity") var highscoreInfinity: Int = 0
    
    var body: some View {
        VStack (alignment: .leading) {
            
            Spacer()
            
            Text("Rules")
                .font(.largeTitle)
                .padding(.bottom)
            
            if mode == "Quick" {
                Group {
                    Text("In Quick mode you play 10 rounds and try to beat your current highscore.")
                    Text("For each correct guess of song title or interpret you get 50 points.")
                    Text("Can you beat your highscore.")
                    
                }
                .font(.title2)
            } else if mode == "Medium" {
                Group {
                    Text("In Medium mode you play 20 rounds and try to beat your current highscore.")
                    Text("For each correct guess of song title or interpret you get 50 points.")
                    Text("Can you beat your highscore.")
                }
                .font(.title2)
            } else if mode == "Infinity" {
                Group {
                    Text("In infinty mode you can play as long as you answer correct.")
                    Text("If you answer incorrectly your round is over and you have to try and beat your highscore again.")
                    Text("For each correct guess of song title or interpret you get 50 points.")
                    Text("Can you beat your highscore")
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
    StartGameView(mode: "Infinity")
}
