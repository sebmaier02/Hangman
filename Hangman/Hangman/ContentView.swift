import SwiftUI
import WebKit

struct ContentView: View {
    // AppStorage property wrapper to store and retrieve highscore value
    @AppStorage("highscore") var highscore: Int = 0
    
    let bwl = Color("BWLColor")
    let wwl = Color("WWLColor")
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("Hangman_image") // Display Hangman image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(.bottom, 300)
                
                VStack{ // Vertical stack for other views
                    Text("Welcome to Hangman!") // Welcome text
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(bwl)
                        .multilineTextAlignment(.center)
                        .padding(.top, 450)
                    
                    Text("Your Highscore: \(highscore)") // Display highscore
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(bwl)
                        .padding(.top, 10)
                    
                    NavigationLink(destination: StartGameView()) { // Navigation link to StartGameView
                        Text("Start Game")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(.semibold)
                            .foregroundStyle(wwl)
                            .padding()
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                            .background(bwl)
                            .clipShape(.rect(cornerRadius: 20))
                            .shadow(color: bwl.opacity(0.5), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y: 5)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
