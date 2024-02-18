import SwiftUI
import WebKit

struct ContentView: View {
    var body: some View {
        
        NavigationView {
            VStack(spacing: 30) {
                Spacer()
                
                Image("Hangman_image")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(.top, -100)
                    
                Spacer()
                
                Text("Welcome to Hangman!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 40)
                    .padding(.top, -100)
                
                NavigationLink(destination: StartGameView(mode: "Start Game")) {
                    ButtonView(text: "Start Game")
                }
                
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

private struct ButtonView: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.title)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.black)
            .cornerRadius(20)
            .shadow(color: Color.blue.opacity(0.5), radius: 10, x: 0, y: 5)
    }
}
