import SwiftUI

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
            
            
            
            Button(action: {
                // Action for Quick Game button
            }) {
                Text("Quick Game")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(20)
                    .shadow(color: Color.blue.opacity(0.5), radius: 10, x: 0, y: 5)
            }
            
            Button(action: {
                // Action for Medium Game button
            }) {
                Text("Medium Game")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(20)
                    .shadow(color: Color.blue.opacity(0.5), radius: 10, x: 0, y: 5)
            }
            
            Button(action: {
                // Action for Long Game button
            }) {
                Text("Long Game")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(20)
                    .shadow(color: Color.blue.opacity(0.5), radius: 10, x: 0, y: 5)
            }
            
            Spacer()
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.white]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
