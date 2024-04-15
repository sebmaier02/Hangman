import SwiftUI

struct NextLevelView: View {
    @ObservedObject var state: StateModel // ObservedObject to manage state
    
    @AppStorage("highscore") var highscore: Double = 0 // AppStorage for storing high score
    @AppStorage("streak") var streak: Double = 0
    
    var word: String // The word to be displayed
    
    var body: some View {
        VStack {
            if !state.gameover { // If game is not over
                // Display congratulations and prompt to continue
                Spacer()
                
                Text("Well done!")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.BWL)
                
                Spacer()
                
                Image(uiImage: .happyFace)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .padding(.horizontal, 120)
                
                Spacer()
                
                Text("Stats")
                    .font(.largeTitle)
                    .foregroundStyle(.BWL)
                    .bold()
                
                HStack {
                    Group {
                        VStack {
                            Text("Streak")
                            
                            Text("\(String(format: "%.0f", state.streak))")
                        }
                        
                        VStack {
                            Text("Points")
                            
                            Text("\(String(format: "%.0f", state.highscore))")
                        }
                    }
                    .font(.title2)
                    .foregroundStyle(.BWL)
                    .background(.gray.opacity(0.3))
                    .clipShape(.rect(cornerRadius: 20))
                }
                
                Spacer()
                
                // Button to proceed to the next level
                Text("Next")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(.semibold)
                    .foregroundStyle(.WWL)
                    .padding()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .background(.BWL)
                    .clipShape(.rect(cornerRadius: 20))
                    .shadow(color: .BWL.opacity(0.5), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y: 5)
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
                    .bold()
                    .foregroundColor(.BWL)
                
                Text(word.uppercased()) // Display the word
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.BWL)
                
                Spacer()
                
                Image(uiImage: .sadFace)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .padding(.horizontal, 120)
                
                Spacer()
                
                Text("Streak: \(String(format: "%.0f", state.streak))")
                    .font(.largeTitle)
                    .foregroundStyle(.BWL)
                    .bold()
                
                Text("Final points: \(String(format: "%.0f", state.score))")
                    .font(.largeTitle)
                    .foregroundStyle(.BWL)
                    .bold()
                
                Spacer()
                
                // Button to end the game
                Text("End game")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(.semibold)
                    .foregroundStyle(.WWL)
                    .padding()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .background(.BWL)
                    .clipShape(.rect(cornerRadius: 20))
                    .shadow(color: .BWL.opacity(0.5), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y: 5)
                    .onTapGesture {
                        if state.score > highscore { // If current score is higher than highscore
                            highscore = state.score // Update highscore
                        }
                        
                        if state.streak > streak {
                            streak = state.streak
                        }
                        
                        state.end.toggle() // Toggle end state
                    }
                
                Spacer()
            }
        }
        .padding(.horizontal)
    }
}
