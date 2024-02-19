//
//  EndGame.swift
//  Hangman
//
//  Created by Sebastian Maier on 18.02.24.
//

import SwiftUI

struct NextLevelView: View {
    @ObservedObject var state: StateModel
    @AppStorage("highscore") var highscore: Int = 0
    var body: some View {
        VStack {
            if !state.gameover {
                Text("Score: \(state.score)")
                Text("Next one")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 5)
                    .onTapGesture {
                        state.playing.toggle()
                    }
            } else {
                Text("Final score: \(state.score)")
                Text("End game")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 5)
                    .onTapGesture {
                        if state.score > highscore {
                            highscore = state.score
                        }
                        state.end.toggle()
                    }
            }
        }
        .padding()
    }
}
