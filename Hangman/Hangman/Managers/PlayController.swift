import SwiftUI

struct PlayController: View {
    @StateObject var state = StateModel()
    
    @State var keyValueDict: [Character: Bool] = [:]
    @State var wordArray: [[String]] = []
    @State var showWarning: Bool = false
    @State var showInfo: Bool = false
    @State var randomCategory: Int = 0
    @State var randomWord: Int = 0
    @State var usedWords: Set<String> = []
    
    @Binding var categories: [String]
    
    @AppStorage("highscore") var highscore: Double = 0
    @AppStorage("streak") var streak: Double = 0
    @AppStorage("customHighscore") var customHighscore: Double = 0
    @AppStorage("customStreak") var customStreak: Double = 0
    
    var customMode: Bool
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            if !state.error {
                if state.fetched {
                    if state.playing && !state.prepareWord {
                        GameView(state: state, word: wordArray[randomCategory][randomWord], keyValueDict: keyValueDict)
                    } else if !state.prepareWord {
                        NextLevelView(state: state, word: wordArray[randomCategory][randomWord], customMode: customMode)
                    } else if state.prepareWord{
                        ProgressView()
                            .onAppear {
                                getRandomNumber()
                                mapChars()
                                withAnimation {
                                    state.prepareWord = false
                                    state.playing = true
                                }
                            }
                    }
                } else {
                    FetchingView(state: state, wordArray: $wordArray, categories: $categories)
                }
            } else {
                FetchingErrorView(state: state)
            }
        }
        .onReceive(state.$end) { end in
            if end {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    if state.gameover {
                        endGameAction()
                    } else {
                        showWarning.toggle()
                    }
                } label: {
                    if !state.playing && !state.prepareWord {
                        Image(systemName: "chevron.left.circle")
                            .foregroundStyle(.WWL)
                    } else {
                        Image(systemName: "chevron.left.circle")
                    }
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showInfo.toggle()
                } label: {
                    if !state.playing && !state.prepareWord {
                        Image(systemName: "info.circle")
                            .foregroundStyle(.WWL)
                    } else {
                        Image(systemName: "info.circle")
                    }
                }
            }
        })
        .alert("Loosing Points", isPresented: $showWarning) {
            Button {
                state.end.toggle()
            } label: {
                Text("Leave")
                    .foregroundStyle(.wrong)
            }
            
            Button {
                showWarning.toggle()
            } label: {
                Text ("Stay")
                    .foregroundStyle(.correct)
            }
        } message: {
            Text("If you leave your current score and streak will not be saved.")
                .font(.title2)
                .foregroundColor(.BWL)
                .multilineTextAlignment(.center)
        }
        .alert("Point System", isPresented: $showInfo) {
            Button {
                
            } label: {
                Text("OK")
                    .font(.title2)
                    .foregroundStyle(.BWL)
            }
        } message: {
            Text("Starting with 100 points, each incorrect guess deducts 10 points. However, correctly guessing the word propels you to the next round with a 10% point increase. For instance, reaching the second round boosts your starting points to 110.")
                .font(.title2)
                .foregroundColor(.BWL)
                .multilineTextAlignment(.center)
        }
    }
    
    func getRandomNumber() {
        var newRandomCategory = Int.random(in: 0..<wordArray.count)
        var newRandomWord = Int.random(in: 0..<wordArray[newRandomCategory].count)
        
        while usedWords.contains(wordArray[newRandomCategory][newRandomWord]) {
            newRandomCategory = Int.random(in: 0..<wordArray.count)
            newRandomWord = Int.random(in: 0..<wordArray[newRandomCategory].count)
        }
        
        randomCategory = newRandomCategory
        randomWord = newRandomWord
        
        usedWords.insert(wordArray[randomCategory][randomWord])
        
        print("Word: \(wordArray[randomCategory][randomWord])")
    }
    
    func mapChars() {
        keyValueDict = [:]
        let word = wordArray[randomCategory][randomWord].uppercased()
        
        for char in word {
            if char != " " {
                if keyValueDict[char] == nil {
                    keyValueDict[char] = false
                }
            }
        }
        print(keyValueDict)
    }
    
    func endGameAction() {
        if customMode {
            if state.score > customHighscore {
                customHighscore = state.score
            }
            
            if state.streak > customStreak {
                customStreak = state.streak
            }
        } else {
            if state.score > highscore {
                highscore = state.score
            }
            
            if state.streak > streak {
                streak = state.streak
            }
        }
        
        state.end.toggle()
    }
}
