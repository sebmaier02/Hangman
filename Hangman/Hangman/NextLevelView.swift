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
                Spacer()
                
                Text("Well done!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(bwl)
                    .multilineTextAlignment(.center)
                
                Text("Let's keep going!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(bwl)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                Text("Score: \(state.score)")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(bwl)// Display current score
                
                Spacer()
                
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
                
                Spacer()
            } else { // If game is over
                // Display the word and a message for the end of the game
                Spacer()
                
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
                
                Spacer()
                
                Text("Too bad.")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(bwl)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                Text("Maybe next time ;)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(bwl)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                Text("Final score: \(state.score)")
                    .font(.largeTitle)
                    .foregroundStyle(bwl)
                    .bold()
                
                Spacer()
                
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
                
                Spacer()
            }
        }
        .padding(.horizontal)
    }
}
