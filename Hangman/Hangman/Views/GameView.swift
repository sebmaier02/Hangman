import SwiftUI

struct GameView: View {
    @ObservedObject var state: StateModel
    
    @AppStorage("highscore") var highscore: Double = 0
    @AppStorage("streak") var streak: Double = 0
    
    @State var errors: Int = 0
    @State var wordCharArray: [Character]
    @State var emptyWordCharArray: [Character]
    @State var emptyWordCharArray2: [Character]
    @State var completed: Bool = false
    @State var oversize: Bool = false
    
    let alphabetArray: [Alphabet] = [.alphabet1, .alphabet2, .alphabet3, .alphabet4]
    let pictures: [UIImage] = [.hangmanwsvg1, .hangmanwsvg2, .hangmanwsvg3, .hangmanwsvg4, .hangmanwsvg5, .hangmanwsvg6, .hangmanwsvg7, .hangmanwsvg8, .hangmanwsvg9]
    
    init(state: StateModel, word: String) {
        let uppercasedWord = word.uppercased()
        _wordCharArray = State(initialValue: Array(uppercasedWord))
        if (word.count < 12) {
            oversize = false
            _emptyWordCharArray = State(initialValue: Array(repeating: " ", count: uppercasedWord.count))
            _emptyWordCharArray2 = State(initialValue: Array(repeating: " ", count: uppercasedWord.count))
        } else {
            let halfsize = uppercasedWord.count / 2;
            oversize = true
            _emptyWordCharArray = State(initialValue: Array(repeating: " ", count: halfsize))
            _emptyWordCharArray2 = State(initialValue: Array(repeating: " ", count: uppercasedWord.count-halfsize))
        }
        self.state = state
    }
    
    var body: some View {
        VStack (alignment: .center) {
            Color.blackboard
                .frame(maxHeight: .infinity)
                .frame(maxWidth: .infinity)
                .border(.blackboardBorder, width: 10)
                .cornerRadius(20)
                .overlay {
                    VStack {
                        ZStack {
                            Color.gray.opacity(0)
                                .aspectRatio(1.0, contentMode: .fit)
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal, 40)
                            
                            ForEach(0..<errors, id: \.self) { index in
                                Image(uiImage: pictures[index])
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: .infinity)
                                    .padding(.horizontal, 40)
                            }
                        }
                        
                        VStack {
                            if !oversize {
                                DisplayLines(wordCharArray: $emptyWordCharArray)
                                    .padding(.top, 40)
                            } else {
                                DisplayLines(wordCharArray: $emptyWordCharArray)
                                    .padding(.bottom, 10)
                                
                                DisplayLines(wordCharArray: $emptyWordCharArray2)
                            }
                        }
                    }
                    .frame(alignment: .bottom)
                }
            
            Spacer(minLength: 40)
            
            ForEach(alphabetArray, id: \.self) { alphabet in
                HStack(alignment: .center) {
                    ForEach(alphabet.letters, id: \.self) { letter in
                        DisplayKeyboard(state: state, errors: $errors, wordCharArray: $wordCharArray, emptyWordCharArray: $emptyWordCharArray, emptyWordCharArray2: $emptyWordCharArray2, oversize: $oversize, character: letter, completed: $completed)
                    }
                }
            }
        }
        .padding()
        .onChange(of: emptyWordCharArray) {
            checkIfEnd()
        }
        .onChange(of: emptyWordCharArray2) {
            checkIfEnd()
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func checkIfEnd() {
        let combinedEmptyWordCharArray = oversize ? emptyWordCharArray + emptyWordCharArray2 : emptyWordCharArray
        if combinedEmptyWordCharArray == wordCharArray {
            endgame()
        }
    }
    
    func endgame() {
        completed.toggle()
        let basepoints: Double = 100 * (1 + (state.streak / 10))
        let errorPoints: Double = Double(errors * 10)
        state.score += (basepoints - errorPoints)
        state.streak += 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            state.playing.toggle()
        }
    }
}
