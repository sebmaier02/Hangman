//
//  StartGameview.swift
//  GuessTheSong
//
//  Created by Sebastian Maier on 02.02.24.
//

import SwiftUI

struct StartGameView: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("highscore") var highscore: Int = 0
    var body: some View {
        VStack (alignment: .center) {
            
            Spacer()
            
            Text("Rules")
                .font(.largeTitle)
                .padding(.bottom, 20)
            
            VStack {
                Text("In this mode you will get a random english word.")
                Text("By guessing the characters you will either get one step closer to the right answer, or one step closer to \"hangman\".")
                Text("Now go on and reach for the stars!")
            }
            .padding()
            .background(Color.gray.opacity(0.3))
            .cornerRadius(20)
            .font(.title2)
            .foregroundColor(.black)
            .multilineTextAlignment(.center)
            
            Spacer()
            
            Text("Highscore: \(highscore)")
                .font(.largeTitle)
                .padding(.bottom)
            
            Text("")
                .font(.title2)
            
            Spacer()
            
            NavigationLink{
                PlayControllerView()
            } label: {
                Text("Start")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 5)
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    StartGameView()
}
