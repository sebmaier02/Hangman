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
    var word: String = "GayTobi"
    @State var errors: Int = 0
    let pictures = ["hangman00", "hangman01", "hangman02","hangman03", "hangman04", "hangman05", "hangman06", "hangman07", "hangman08", "hangman09", "hangman10"]
    @State private var wordCharArray: [Character]
    @State private var emptyWordCharArray: [Character]
    @Environment(\.dismiss) var dismiss
    @State var gameover: Bool = false
    
    init() {
        let uppercasedWord = word.uppercased()
        _wordCharArray = State(initialValue: Array(uppercasedWord))
        _emptyWordCharArray = State(initialValue: Array(repeating: " ", count: uppercasedWord.count))
    }
    
    var body: some View {
        VStack (alignment: .center){
            Image(pictures[errors])
                .resizable()
                .scaledToFit()
                .frame(height: 350)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 10)
                .cornerRadius(20)
            
            Spacer()
            
            displayLines(characterCount: emptyWordCharArray.count, wordCharArray: $emptyWordCharArray)
            Spacer()
            HStack(alignment: .center) {
                ForEach(alphabet1, id: \.self) { letter in
                    displayLetter(character: letter)
                }
            }
            HStack(alignment: .center) {
                ForEach(alphabet2, id: \.self) { letter in
                    displayLetter(character: letter)
                }
            }
            HStack(alignment: .center) {
                ForEach(alphabet3, id: \.self) { letter in
                    displayLetter(character: letter)
                }
            }
            HStack(alignment: .center) {
                ForEach(alphabet4, id: \.self) { letter in
                    displayLetter(character: letter)
                }
            }
        }
        .padding()
        .alert("Gameover", isPresented: $gameover) {
            NavigationLink(destination: EndGameView()) {
                Button {
                    
                } label: {
                    Text("OK")
                }
            }
        } message: {
            Text("Better luck next time :)")
        }
    }
    
    func displayLetter(character: Character) -> some View {
        Hangman.displayLetter(errors: $errors, character: character, wordCharArray: wordCharArray, emptyWordCharArray: $emptyWordCharArray, gameover: $gameover)
    }
}

struct displayLetter: View {
    @Binding var errors: Int
    var character: Character
    var wordCharArray: [Character]
    @State var taped: Bool = false
    @Binding var emptyWordCharArray: [Character]
    @State var op: Double = 1.0
    @State var correct: Bool = false
    @Environment(\.dismiss) var dismiss
    @Binding var gameover: Bool
    
    var body: some View {
        Color.gray
            .opacity(op)
            .frame(width: 40, height: 50)
            .cornerRadius(5)
            .overlay() {
                Text(String(character))
            }
            .onTapGesture {
                if !taped {
                    for index in wordCharArray.indices {
                        if character == wordCharArray[index] {
                            emptyWordCharArray[index] = character
                            correct = true
                        }
                    }
                    if !correct {
                        errors = errors + 1
                    }
                    correct = false
                    
                    if errors == 10 {
                        gameover.toggle()
                    }
                    
                    op = 0.2
                    taped.toggle()
                }
            }
    }
}

struct displayLines: View {
    var characterCount: Int
    @Binding var wordCharArray: [Character]
    
    var body: some View {
        HStack {
            ForEach(0..<characterCount) { index in
                VStack {
                    Text(String(wordCharArray[index]))
                        .padding(.bottom, -18)
                    Image("strich3")
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
