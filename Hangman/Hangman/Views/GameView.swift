import SwiftUI

struct GameView: View {
    @ObservedObject var state: StateModel
    
    @State var errors: Int = 0
    @State var wordCharArray: [Character]
    @State var completed: Bool = false
    @State var keyValueDict: [Character: Bool]
    
    let alphabetArray: [Alphabet] = [.alphabet1, .alphabet2, .alphabet3, .alphabet4]
    let pictures: [UIImage] = [.hangmanwsvg1, .hangmanwsvg2, .hangmanwsvg3, .hangmanwsvg4, .hangmanwsvg5, .hangmanwsvg6, .hangmanwsvg7, .hangmanwsvg8, .hangmanwsvg9]
    
    init(state: StateModel, word: String, keyValueDict: [Character: Bool] ) {
        let uppercasedWord = word.uppercased()
        _keyValueDict = State(initialValue: keyValueDict)
        _wordCharArray = State(initialValue: Array(uppercasedWord))
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
                        Spacer()
                        ZStack {
                            if errors == 0 {
                                Color.gray.opacity(0)
                                    .aspectRatio(1.0, contentMode: .fit)
                                    .frame(maxWidth: .infinity)
                                    .padding(.horizontal, 40)
                            } else {
                                ForEach(0..<errors, id: \.self) { index in
                                    Image(uiImage: pictures[index])
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxWidth: .infinity)
                                        .padding(.horizontal, 40)
                                }
                            }
                        }
                        
                        VStack {
                            
                            DisplayLines(wordCharArray: $wordCharArray, keyValueDict: $keyValueDict)
                                .padding(.top, 40)
                        }
                        Spacer()
                    }
                    .frame(alignment: .bottom)
                }
            
            Spacer(minLength: 40)
            
            ForEach(alphabetArray, id: \.self) { alphabet in
                HStack(alignment: .center) {
                    ForEach(alphabet.letters, id: \.self) { letter in
                        DisplayKeyboard(state: state, errors: $errors, wordCharArray: $wordCharArray, keyValueDict: $keyValueDict, character: letter, completed: $completed)
                    }
                }
            }
        }
        .padding()
        .onChange(of: keyValueDict) {
            checkIfEnd()
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func checkIfEnd() {
        if keyValueDict.allSatisfy({ $0.value == true }) {
            endgame()
        }
    }
    
    func endgame() {
        completed = true
        let basepoints: Double = 100 * (1 + (state.streak / 10))
        let errorPoints: Double = Double(errors * 10)
        state.score += (basepoints - errorPoints)
        state.streak += 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation {
                state.playing = false
            }
        }
    }
    
    
}
