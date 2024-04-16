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
                    Text("Play")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .bold()
                        .foregroundStyle(.WWL)
                        .padding()
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .background(.BWL)
                        .clipShape(.rect(cornerRadius: 20))
                        .shadow(color: .BWL.opacity(0.5), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y: 5)
                        .padding(.horizontal, 70)
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
