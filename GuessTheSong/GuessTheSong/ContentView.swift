import SwiftUI
import WebKit

struct ContentView: View {
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Text("Welcome to Guess the Song!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
                .padding(.vertical, 40)
            
            ButtonView(text: "Quick")
            
            ButtonView(text: "Medium")
            
            ButtonView(text: "Infinity")
            
            Spacer()
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.white]), startPoint: .bottom, endPoint: .top)
                .edgesIgnoringSafeArea(.all)
        )
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
        Button(action: {
            // Action for Medium Game button
        }) {
            Text(text)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(20)
                .shadow(color: Color.blue.opacity(0.5), radius: 10, x: 0, y: 5)
        }
    }
}
