import SwiftUI

struct DisplayLines: View {
    @Binding var wordCharArray: [Character]
    @Binding var keyValueDict: [Character: Bool]
    
    let underscore: UIImage = .unterstrich1
    
    var body: some View {
        VStack {
            ForEach(Array(splitIntoLines().enumerated()), id: \.0) { index, line in
                HStack {
                    ForEach(Array(line.enumerated()), id: \.0) { charIndex, char in
                        if char != " " {
                            VStack {
                                let textToShow = keyValueDict[char] ?? false ? "\(char)" : " "
                                
                                Text(textToShow)
                                    .font(Font.custom("Miology", size: 20))
                                    .foregroundStyle(.white)
                                    .frame(maxWidth: 20)
                                    .padding(.bottom, -20)
                                
                                Image(uiImage: underscore)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 20)
                            }
                        } else {
                            VStack {
                            }
                            .frame(maxWidth: 20)
                        }
                    }
                }
                .padding(.horizontal, 40)
            }
        }
        
    }
    
    // Function to split the character array into lines based on character count limits
    func splitIntoLines() -> [[Character]] {
        var lines: [[Character]] = [[]]
        var currentLineLength: Int = 0
        
        for word in splitIntoWords() {
            let wordLength = word.count
            if currentLineLength + wordLength > 12 {
                // Prüfe, ob das letzte Zeichen im aktuellen Array ein Leerzeichen ist, bevor eine neue Zeile erstellt wird
                if lines[lines.endIndex - 1].last == " " {
                    lines[lines.endIndex - 1].removeLast()
                }
                
                lines.append([])
                currentLineLength = 0  // Rücksetzen der Zeilenlänge für die neue Zeile
            }
            lines[lines.endIndex - 1] += word
            currentLineLength += wordLength
        }
        
        // Entferne ein eventuell letztes Leerzeichen auch am Ende der letzten Zeile
        if lines.last?.last == " " {
            lines[lines.endIndex - 1].removeLast()
        }
        
        return lines
    }
    
    
    // Function to split the input string into words including spaces
    func splitIntoWords() -> [[Character]] {
        var words: [[Character]] = [[]]
        var newWord = true
        
        for char in wordCharArray {
            if char == " " {
                if !newWord {
                    words.append([char])
                    newWord = true
                } else {
                    words[words.count - 1].append(char)
                }
            } else {
                if newWord {
                    words.append([char])
                    newWord = false
                } else {
                    words[words.count - 1].append(char)
                }
            }
        }
        
        return words
    }
}
