//
//  DisplayKeyboard.swift
//  Hangman
//
//  Created by Sebastian Maier on 22.04.24.
//

import SwiftUI

struct DisplayKeyboard: View {
    @ObservedObject var state: StateModel
    
    @Binding var errors: Int
    @Binding var wordCharArray: [Character]
    @Binding var emptyWordCharArray: [Character]
    
    @State var tapped: Bool = false
    @State var correct: Bool = false
    @State var color = Color.gray.opacity(0.3)
    
    var character: Character
    
    @Binding var completed: Bool
    
    var body: some View {
        color
            .frame(width: 40, height: 50)
            .cornerRadius(5)
            .shadow(color: color.opacity(0.5), radius: 5, x: 0, y: 5)
            .overlay() {
                Text(String(character))
                    .font(Font.custom("Miology", size: 28))
            }
            .onTapGesture {
                guard !completed, !tapped else { return }
                
                var found = false
                for (index, char) in wordCharArray.enumerated() {
                    if char == character {
                        emptyWordCharArray[index] = character
                        found = true
                    }
                }
                
                if found {
                    color = .correct
                } else {
                    errors += 1
                    color = .wrong
                    if errors == 9 {
                        state.gameover.toggle()
                        completed.toggle()
                        state.playing.toggle()
                    }
                }
                
                tapped.toggle()
            }
    }
}
