import SwiftUI
import WebKit

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Text("Welcome to")
                    .font(.largeTitle)
                    .foregroundStyle(.BWL)
                    .bold()
                
                
                Image(uiImage: .homescreen)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                
                Spacer()
                
                NavigationLink(destination: StartGameView()) {
                    Text("Play")
                        .font(.title)
                        .bold()
                        .foregroundStyle(.WWL)
                        .padding()
                        .padding(.horizontal, 60)
                        .background(.correct)
                        .clipShape(.rect(cornerRadius: 20))
                        .shadow(color: .BWL.opacity(0.3), radius: 10, x: 0, y: 5)
                }
                
                Spacer()
            }
            .padding(.horizontal)
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gearshape.circle")
                            .foregroundStyle(.BWL)
                    }
                }
            })
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
