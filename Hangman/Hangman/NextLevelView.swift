import SwiftUI

struct NextLevelView: View {
    @ObservedObject var state: StateModel // ObservedObject to manage state
    
    @AppStorage("highscore") var highscore: Int = 0 // AppStorage for storing high score
    
    var word: String // The word to be displayed
    
    let bwl = Color("BWLColor")
    let wwl = Color("WWLColor")
    
    var body: some View {
        VStack {
            if !state.gameover { // If game is not over
                // Display congratulations and prompt to continue
                Text("Well done!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(bwl)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, -12)
                
                Text("Let's keep going!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(bwl)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 60)
                
                Text("Score: \(state.score)") // Display current score
                
                // Button to proceed to the next level
                Text("next one")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(.semibold)
                    .foregroundStyle(wwl)
                    .padding()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .background(bwl)
                    .clipShape(.rect(cornerRadius: 20))
                    .shadow(color: bwl.opacity(0.5), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y: 5)
                    .onTapGesture {
                        state.fetched.toggle() // Toggle fetched state
                        state.playing.toggle() // Toggle playing state
                    }
            } else { // If game is over
                // Display the word and a message for the end of the game
                Text("The word was:")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(bwl)
                    .multilineTextAlignment(.center)
                
                Text(word.uppercased()) // Display the word
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(bwl)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 18)
                
                Text("Too bad.")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(bwl)
                    .multilineTextAlignment(.center)
                
                Text("Maybe next time ;)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(bwl)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 60)
                
                Text("Final score: \(state.score)")
                    .foregroundStyle(bwl)
                
                // Button to end the game
                Text("End game")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(.semibold)
                    .foregroundStyle(wwl)
                    .padding()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .background(bwl)
                    .clipShape(.rect(cornerRadius: 20))
                    .shadow(color: bwl.opacity(0.5), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y: 5)
                    .onTapGesture {
                        if state.score > highscore { // If current score is higher than highscore
                            highscore = state.score // Update highscore
                        }
                        state.end.toggle() // Toggle end state
                    }
            }
        }
        .padding()
    }
}
