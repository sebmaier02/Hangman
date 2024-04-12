import SwiftUI
import WebKit

struct ContentView: View {
    // AppStorage property wrapper to store and retrieve highscore value
    @AppStorage("highscore") var highscore: Int = 0
    
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
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding(.top, 450)
                    
                    Text("Your Highscore: \(highscore)") // Display highscore
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.top, 10)
                    
                    NavigationLink(destination: StartGameView()) { // Navigation link to StartGameView
                        ButtonView(text: "Start Game") // Button to start game
                            .padding(.top, 70)
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

// ButtonView: Custom button view
private struct ButtonView: View {
    var text: String // Text to display on the button
    
    var body: some View {
        Button {
            
        } label: {
            Text(text)
        }.font(.title)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.black) // Black background
            .cornerRadius(20) // Rounded corners
            .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 5) // Shadow effect
    }
    
}
