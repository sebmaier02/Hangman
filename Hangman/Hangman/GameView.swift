import SwiftUI

struct GameView: View {
    @ObservedObject var state: StateModel
    
    @AppStorage("highscore") var highscore: Double = 0
    @AppStorage("streak") var streak: Double = 0
    
    @State var errors: Int = 0
    @State var wordCharArray: [Character]
    @State var emptyWordCharArray: [Character]
    @State var completed: Bool = false
    @State var showInfo: Bool = false
    @State var showWarning: Bool = false
    
    let alphabet1 = Array("ABCDEF")
    let alphabet2 = Array("GHIJKLM")
    let alphabet3 = Array("NOPQRS")
    let alphabet4 = Array("TUVWXYZ")
    let alphabetArray: [[Character]]
    
    let pictures: [UIImage] = [.hangmanwsvg1, .hangmanwsvg2, .hangmanwsvg3, .hangmanwsvg4, .hangmanwsvg5, .hangmanwsvg6, .hangmanwsvg7, .hangmanwsvg8, .hangmanwsvg9]
    
    init(word: String, state: StateModel) {
        let uppercasedWord = word.uppercased()
        _wordCharArray = State(initialValue: Array(uppercasedWord))
        _emptyWordCharArray = State(initialValue: Array(repeating: " ", count: uppercasedWord.count))
        self.state = state
        alphabetArray = [alphabet1, alphabet2, alphabet3, alphabet4]
    }
    
    var body: some View {
        VStack (alignment: .center) {
            Color(red: 39/255, green: 76/255, blue: 67/255)
                .frame(maxHeight: .infinity)
                .frame(maxWidth: .infinity)
                .border(Color(UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1.0)), width: 10)
                .cornerRadius(20)
                .overlay {
                    VStack {
                        ZStack {
                            Color.gray.opacity(0)
                                .aspectRatio(1.0, contentMode: .fit)
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
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
                            displayLines(characterCount: wordCharArray.count, wordCharArray: $emptyWordCharArray)
                                .padding(.top, 40)
                            
                        }
                        
                    }
                    .frame(alignment: .bottom)
                }
            
            Spacer(minLength: 40)
            
            ForEach(0..<alphabetArray.count) { index in
                HStack(alignment: .center) {
                    ForEach(alphabetArray[index], id: \.self) { letter in
                        displayLetter(state: state, errors: $errors, wordCharArray: $wordCharArray, emptyWordCharArray: $emptyWordCharArray, character: letter, completed: $completed)
                    }
                }
            }
            
        }
        .padding()
        .onChange(of: emptyWordCharArray) {
            if emptyWordCharArray == wordCharArray {
                completed.toggle()
                let basepoints: Double = 100*(1+(state.streak/10))
                let errorPoints: Double = Double(errors*10)
                state.score += (basepoints-errorPoints)
                state.streak += 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    state.playing.toggle()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    showWarning.toggle()
                }) {
                    Text("\(Image(systemName: "chevron.left"))")
                        .fontWeight(.bold)
                }
                .alert("Loosing Points", isPresented: $showWarning) {
                    HStack {
                        Button {
                            state.end.toggle()
                        } label: {
                            Text("Leave")
                                .foregroundStyle(.red)
                        }
                        
                        Button {
                            showWarning.toggle()
                        } label: {
                            Text ("Stay")
                                .foregroundStyle(.green)
                        }
                    }
                } message: {
                    Text("If you leave your current score and streak will not be saved.")
                        .font(.title2)
                        .foregroundColor(.BWL)
                        .multilineTextAlignment(.center)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Image(systemName: "info.circle")
                    .onTapGesture {
                        showInfo.toggle()
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
        })
    }
}

// View to display a letter
struct displayLetter: View {
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
                if !completed {
                    if !tapped {
                        for index in wordCharArray.indices {
                            if character == wordCharArray[index] {
                                emptyWordCharArray[index] = character
                                correct = true
                                
                            }
                        }
                        
                        if !correct {
                            errors += 1
                            color = .wrong
                        } else {
                            color = .correct
                        }
                        
                        correct = false
                        
                        if errors == 9 {
                            state.gameover.toggle()
                            completed.toggle()
                            state.playing.toggle()
                        }
                        
                        tapped.toggle()
                    }
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
                        .font(Font.custom("Miology", size: 20))
                        .foregroundStyle(.white)
                        .frame(maxWidth: 20)
                        .padding(.bottom, -20)
                    
                    Image(uiImage: .unterstrich1)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 20)
                }
            }
        }
        .padding(.horizontal, 40)
    }
}
