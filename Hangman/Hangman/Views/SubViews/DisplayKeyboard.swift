//
//  DisplayKeyboard.swift
//  Hangman
//
//  Created by Sebastian Maier on 22.04.24.
//

import SwiftUI

struct DisplayKeyboard: View {
    @ObservedObject var state: StateModel
    
    @AppStorage("hapticFeedback") var hapticFeedback: Bool = false
    
    @Binding var errors: Int
    @Binding var wordCharArray: [Character]
    @Binding var keyValueDict: [Character: Bool]
    
    @State var tapped: Bool = false
    @State var correct: Bool = false
    @State var wrong: Bool = false
    @State var color = Color.gray.opacity(0.3)
    
    var character: Character
    
    @Binding var completed: Bool
    
    var body: some View {
        color
            .frame(width: 40, height: 50)
            .cornerRadius(5)
            .shadow(color: .BWL.opacity(tapped ? 0.2 : 0), radius: 5, x: 0, y: 5)
            .overlay() {
                Text(String(character))
                    .font(Font.custom("Miology", size: 28))
            }
            .onTapGesture {
                guard !completed, !tapped else { return }
                
                var found = false
                
                if keyValueDict[character] != nil {
                    found = true
                    keyValueDict[character] = true
                }
                
                if found {
                    withAnimation {
                        color = .correct
                    }
                    correct = true
                } else {
                    wrong = true
                    errors += 1
                    withAnimation {
                        color = .wrong
                    }
                    if errors == 9 {
                        completed = true
                        withAnimation {
                            state.gameover = true
                            state.playing = false
                        }
                    }
                }
                
                withAnimation {
                    tapped = true
                }
                
                triggerFeedback()
            }
    }
    
    func triggerFeedback() {
        if hapticFeedback {
            if correct {
                UINotificationFeedbackGenerator().notificationOccurred(.success)
            } else if wrong {
                UINotificationFeedbackGenerator().notificationOccurred(.error)
            }
        }
    }
}
