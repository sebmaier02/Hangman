//
//  GameView.swift
//  Hangman
//
//  Created by Tobias Pummer on 18.02.24.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var state: StateModel
    let alphabet1 = Array("ABCDEF")
    let alphabet2 = Array("GHIJKLM")
    let alphabet3 = Array("NOPQRS")
    let alphabet4 = Array("TUVWXYZ")
    @State var errors: Int = 0
    let pictures = ["hangman00", "hangman01", "hangman02","hangman03", "hangman04", "hangman05", "hangman06", "hangman07", "hangman08", "hangman09", "hangman10"]
    @State var wordCharArray: [Character]
    @State var emptyWordCharArray: [Character]
    @AppStorage("highscore") var highscore: Int = 0
    @State var characterCount: Int
    @State var completed: Bool = false
    
    init(word: String, state: StateModel) {
        let uppercasedWord = word.uppercased()
        _wordCharArray = State(initialValue: Array(uppercasedWord))
        _emptyWordCharArray = State(initialValue: Array(repeating: " ", count: uppercasedWord.count))
        _characterCount = State(initialValue: uppercasedWord.count)
        self.state = state
    }
    
    var body: some View {
        VStack (alignment: .center){
            ZStack {
                Image(pictures[errors])
                    .resizable()
                    .scaledToFit()
                    .frame(height: 350)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 10)
                    .cornerRadius(20)
            }
            
            Spacer()
            
            displayLines(characterCount: $characterCount, wordCharArray: $emptyWordCharArray)
            
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
        .onChange(of: emptyWordCharArray) { _ in
            if emptyWordCharArray == wordCharArray {
                completed.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    state.playing.toggle()
                }
            }
        }
    }
    
    func displayLetter(character: Character) -> some View {
        Hangman.displayLetter(state: state,errors: $errors, character: character, wordCharArray: $wordCharArray, emptyWordCharArray: $emptyWordCharArray, completed: $completed)
    }
}

struct displayLetter: View {
    @ObservedObject var state: StateModel
    @Binding var errors: Int
    var character: Character
    @Binding var wordCharArray: [Character]
    @State var tapped: Bool = false
    @Binding var emptyWordCharArray: [Character]
    @State var op: Double = 1.0
    @State var correct: Bool = false
    @Environment(\.dismiss) var dismiss
    @Binding var completed: Bool
    
    var body: some View {
        Color.gray
            .opacity(op)
            .frame(width: 40, height: 50)
            .cornerRadius(5)
            .overlay() {
                Text(String(character))
            }
            .onTapGesture {
                if !completed {
                    if !tapped {
                        for index in wordCharArray.indices {
                            if character == wordCharArray[index] {
                                emptyWordCharArray[index] = character
                                correct = true
                                state.score += 10
                            }
                        }
                        if !correct {
                            errors = errors + 1
                        }
                        correct = false
                        
                        if errors == 10 {
                            state.gameover.toggle()
                            completed.toggle()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                state.playing.toggle()
                            }
                        }
                        
                        op = 0.2
                        tapped.toggle()
                    }
                }
            }
    }
}

struct displayLines: View {
    @Binding var characterCount: Int
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
