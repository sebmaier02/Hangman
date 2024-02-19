import SwiftUI

struct NextLevelView: View {
    @ObservedObject var state: StateModel // ObservedObject to manage state
    
    @AppStorage("highscore") var highscore: Int = 0 // AppStorage for storing high score
    
    var word: String // The word to be displayed
    
    var body: some View {
        VStack {
            if !state.gameover { // If game is not over
                // Display congratulations and prompt to continue
                Text("Well done!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, -12)
                
                Text("Let's keep going!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 60)
                
                Text("Score: \(state.score)") // Display current score
                
                // Button to proceed to the next level
                Text("Next one")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 5)
                    .onTapGesture {
                        state.fetched.toggle() // Toggle fetched state
                        state.playing.toggle() // Toggle playing state
                    }
            } else { // If game is over
                // Display the word and a message for the end of the game
                Text("The word was:")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                
                Text(word.uppercased()) // Display the word
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 18)
                
                Text("Too bad.")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                
                Text("Maybe next time ;)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 60)
                
                Text("Final score: \(state.score)") // Display final score
                
                // Button to end the game
                Text("End game")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 5)
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
