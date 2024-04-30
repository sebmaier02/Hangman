import SwiftUI

struct NextLevelView: View {
    @ObservedObject var state: StateModel
    
    @AppStorage("highscore") var highscore: Double = 0
    @AppStorage("streak") var streak: Double = 0
    @AppStorage("customHighscore") var customHighscore: Double = 0
    @AppStorage("customStreak") var customStreak: Double = 0
    
    var word: String
    
    var customMode: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            if !state.gameover {
                Text("Well done!")
                    .largeTitleStyle()
                
                Image(uiImage: .happyFace)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 120)
                
                Spacer()
                
                Text("Streak: \(formattedStreak)")
                    .largeTitleStyle()
                
                Text("Points: \(formattedScore)")
                    .largeTitleStyle()
                
                Spacer()
                
                ButtonView(text: "Next")
                    .onTapGesture {
                        nextAction()
                    }
            } else {
                Text("The word was:")
                    .largeTitleStyle()
                
                Text(word.uppercased())
                    .largeTitleStyle()
                
                Image(uiImage: .sadFace)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 120)
                
                Spacer()
                
                Text("Streak: \(formattedStreak)")
                    .largeTitleStyle()
                
                Text("Final points: \(formattedScore)")
                    .largeTitleStyle()
                
                if customMode {
                    if state.score > customHighscore {
                        Spacer()
                        Text("New Highscore!!!")
                            .largeTitleStyle()
                    }
                } else {
                    if state.score > highscore {
                        Spacer()
                        Text("New Highscore!!!")
                            .largeTitleStyle()
                    }
                }
                
                Spacer()
                
                ButtonView(text: "End game")
                    .onTapGesture {
                        endGameAction()
                    }
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .navigationBarBackButtonHidden(true)
    }
    
    private var formattedStreak: String {
        String(format: "%.0f", state.streak)
    }
    
    private var formattedScore: String {
        String(format: "%.0f", state.score)
    }
    
    private func nextAction() {
        state.prepareWord = true
    }
    
    private func endGameAction() {
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

extension Text {
    func largeTitleStyle() -> some View {
        self
            .font(.largeTitle)
            .bold()
            .foregroundColor(.BWL)
    }
}

