//
//  StartGameview.swift
//  GuessTheSong
//
//  Created by Sebastian Maier on 02.02.24.
//

import SwiftUI

struct StartGameView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack (alignment: .center) {
            
            Spacer()
            
            Text("Rules")
                .font(.largeTitle)
                .padding(.bottom)
            
            Group {
                Text("You will get a random word and you have to guess it.")
                Text("You can enter one charater at the time an check if it is the word.")
                Text("If correct the letter will apear in the word.")
                Text("I fincorrect the \"Hangman\" will slowly appear")
                Text("Once fully visible the game is over")
            }
            .font(.title2)
            .multilineTextAlignment(.center)
            
            Spacer()
            
            Text("Highscore")
                .font(.largeTitle)
                .padding(.bottom)
            
            Text("47")
                .font(.title2)
            
            Spacer()
            
            NavigationLink{
                GameView()
            } label: {
                Text("Start")
                    .font(.title)
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
        .padding(.horizontal)
    }
}

#Preview {
    StartGameView()
}
