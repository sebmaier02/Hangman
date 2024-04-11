import SwiftUI

struct GameView: View {
    @ObservedObject var state: StateModel // ObservedObject to manage state
    
    @AppStorage("highscore") var highscore: Int = 0 // AppStorage for storing high score
    
    @State var errors: Int = 0 // State variable to track errors
    @State var wordCharArray: [Character] // State variable to store characters of the word
    @State var emptyWordCharArray: [Character] // State variable to store guessed characters
    @State var characterCount: Int // State variable to store word length
    @State var completed: Bool = false // State variable to track completion
    
    // Arrays to hold alphabets and hangman images
    let alphabet1 = Array("ABCDEF")
    let alphabet2 = Array("GHIJKLM")
    let alphabet3 = Array("NOPQRS")
    let alphabet4 = Array("TUVWXYZ")
    let pictures = ["hangmansvg1", "hangmansvg2", "hangmansvg3","hangmansvg4", "hangmansvg5", "hangmansvg6", "hangmansvg7", "hangmansvg8", "hangmansvg9", "hangmansvg10", "hangmansvg11"]
    
    // Constructor to initialize the game view
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
                ForEach(0..<errors, id: \.self) { index in
                    Image(pictures[index]) // Display hangman image based on errors
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200 ,height: 350)
                        .border(Color(UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1.0)), width: 10)
                        .cornerRadius(20)
                }
            }
            
            Spacer()
            
            displayLines(characterCount: $characterCount, wordCharArray: $emptyWordCharArray) // Display lines for each character
            
            Spacer()
            
            // Display alphabets in rows
            HStack(alignment: .center) {
                ForEach(alphabet1, id: \.self) { letter in
                    displayLetter(character: letter) // Display each alphabet
                }
            }
            
            HStack(alignment: .center) {
                ForEach(alphabet2, id: \.self) { letter in
                    displayLetter(character: letter) // Display each alphabet
                }
            }
            
            HStack(alignment: .center) {
                ForEach(alphabet3, id: \.self) { letter in
                    displayLetter(character: letter) // Display each alphabet
                }
            }
            
            HStack(alignment: .center) {
                ForEach(alphabet4, id: \.self) { letter in
                    displayLetter(character: letter) // Display each alphabet
                }
            }
        }
        .padding()
        .onChange(of: emptyWordCharArray) { _ in
            // Check if the word is completed
            if emptyWordCharArray == wordCharArray {
                completed.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    state.playing.toggle() // Toggle playing state
                }
            }
        }
    }
    
    // Function to display each letter
    func displayLetter(character: Character) -> some View {
        // Use the displayLetter view
        Hangman.displayLetter(state: state, errors: $errors, wordCharArray: $wordCharArray, emptyWordCharArray: $emptyWordCharArray, character: character, completed: $completed)
    }
}

// View to display a letter
struct displayLetter: View {
    @ObservedObject var state: StateModel
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var errors: Int
    @Binding var wordCharArray: [Character]
    @Binding var emptyWordCharArray: [Character]
    
    @State var tapped: Bool = false
    @State var op: Double = 1.0
    @State var correct: Bool = false
    
    var character: Character
    
    @Binding var completed: Bool
    
    var body: some View {
        // Display a gray box representing a letter
        Color.gray
            .opacity(op)
            .frame(width: 40, height: 50)
            .cornerRadius(5)
            .overlay() {
                Text(String(character)) // Display the character inside the box
                    .font(Font.custom("Miology", size: 24))
            }
            .onTapGesture {
                if !completed {
                    if !tapped {
                        for index in wordCharArray.indices {
                            if character == wordCharArray[index] {
                                emptyWordCharArray[index] = character // Fill in the guessed character
                                correct = true
                                state.score += 10 // Increase score
                            }
                        }
                        
                        if !correct {
                            errors += 1 // Increment errors if the character is not in the word
                        }
                        
                        correct = false
                        
                        if errors == 11 {
                            
                            state.gameover.toggle() // Toggle gameover state if 10 errors reached
                            completed.toggle()
                            state.playing.toggle()
                        }
                        
                        op = 0.2
                        tapped.toggle()
                    }
                }
            }
    }
}

// View to display lines representing each character of the word
struct displayLines: View {
    @Binding var characterCount: Int
    @Binding var wordCharArray: [Character]
    
    var body: some View {
        HStack {
            ForEach(0..<characterCount) { index in
                VStack {
                    Text(String(wordCharArray[index])) // Display each character
                        .padding(.bottom, -18)
                        .font(Font.custom("Miology", size: 24))
                    
                    Image("strich3") // Display a line beneath each character
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 40, maxHeight: 20)
                }
            }
        }
    }
}
