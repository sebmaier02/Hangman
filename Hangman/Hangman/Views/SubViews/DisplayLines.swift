//
//  DisplayLines.swift
//  Hangman
//
//  Created by Sebastian Maier on 22.04.24.
//

import SwiftUI

struct DisplayLines: View {
    @Binding var emptyWordCharArray: [Character]
    @Binding var wordCharArray: [Character]
    
    let underscore: UIImage = .unterstrich1
    
    var body: some View {
        VStack {
            ForEach(0..<splitIntoWords().count, id: \.self) { index in
                let word = splitIntoWords()[index]
                let offset = calculateOffset(for: index)
                
                HStack {
                    ForEach(0..<word.count, id: \.self) { charIndex in
                        VStack {
                            Text("\(emptyWordCharArray[charIndex + offset + index])")
                                .font(Font.custom("Miology", size: 20))
                                .foregroundStyle(.white)
                                .frame(maxWidth: 20)
                                .padding(.bottom, -20)
                            
                            Image(uiImage: underscore)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 20)
                        }
                    }
                }
                .padding(.horizontal, 40)
            }
        }
    }
    
    // Funktion zum Berechnen des Offsets basierend auf dem aktuellen Index
    func calculateOffset(for currentIndex: Int) -> Int {
        var offset = 0
        var skippedSpaces = 0
        
        // Summiere die Längen der Wörter vor dem aktuellen Wort
        for i in 0..<currentIndex {
            offset += splitIntoWords()[i].count
        }
        
        return offset
    }
    
    // Funktion zum Aufteilen des Wortes in einzelne Wörter
    func splitIntoWords() -> [[Character]] {
        var words: [[Character]] = [[]]
        
        for char in wordCharArray {
            if char == " " {
                if !words.last!.isEmpty {
                    words.append([])
                }
            } else {
                words[words.count - 1].append(char)
            }
        }
        
        // Entferne leere Arrays
        words = words.filter { !$0.isEmpty }
        
        return words
    }
}
