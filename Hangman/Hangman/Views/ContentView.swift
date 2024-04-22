import SwiftUI
import WebKit

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Text("Welcome to Hangman")
                    .font(.largeTitle)
                    .foregroundStyle(.BWL)
                    .bold()
                
                Spacer()
                
                Image(uiImage: .homescreen)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                
                Spacer()
                
                NavigationLink(destination: StartGameView()) {
                    ButtonView(text: "Play")
                }
                
                Spacer()
            }
            .padding(.horizontal)
        }
        .tint(.BWL)
        .navigationBarBackButtonHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
