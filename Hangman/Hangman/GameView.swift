//
//  GameView.swift
//  Hangman
//
//  Created by Tobias Pummer on 18.02.24.
//

import SwiftUI

struct GameView: View {
    let alphabet1 = Array("ABCDEF")
    let alphabet2 = Array("GHIJKLM")
    let alphabet3 = Array("NOPQRS")
    let alphabet4 = Array("TUVWXYZ")
    let chunksize = 7
    var body: some View {
        VStack (alignment: .center){
            Spacer()
            displayLines(characterCount: 10)
            Spacer()
            displayLetters(alphabet: alphabet1)
            displayLetters(alphabet: alphabet2)
            displayLetters(alphabet: alphabet3)
            displayLetters(alphabet: alphabet4)
        }
        .padding()
    }
}

struct displayLetters: View {
    var alphabet: [Character]
    var body: some View {
        HStack {
            ForEach(alphabet, id: \.self) { letter in
                Color.gray
                    .frame(width: 30, height: 40)
                    .cornerRadius(5)
                    .overlay() {
                        Text(String(letter))
                    }
                    .onTapGesture {
                        print(String(letter))
                    }
            }
        }
    }
}

struct displayLines: View {
    var characterCount: Int
    let stringsArray = ["strich1", "strich2", "strich3", "strich4", "strich5", "strich6"]
    var body: some View {
        HStack {
            ForEach(0..<characterCount) {_ in
                let randomNumber = Int.random(in: 0..<6)
                VStack {
                    Text("q")
                    Image(stringsArray[randomNumber])
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 40, maxHeight: 20)
                }
            }
        }
    }
}

#Preview {
    GameView()
}
