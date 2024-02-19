import SwiftUI
import WebKit

struct ContentView: View {
    
    @AppStorage("highscore") var highscore: Int = 0
    
    var body: some View {
        
        NavigationStack {
            VStack {
                ZStack{
                    Image("Hangman_image")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding(.bottom, 300)
                    VStack{
                        
                        Text("Welcome to Hangman!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .padding(.top, 450)
                        
                        Text("Your Highscore: \(highscore)")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.top, 10)
                            
                        
                        NavigationLink(destination: StartGameView()) {
                            ButtonView(text: "Start Game")
                                .padding(.top, 70)
                        }
                    }
                    .padding(.horizontal)
                }
                
               
                Spacer()
                
            }
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
            .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 5)
    }
}
