import SwiftUI

struct PlayControllerView: View {
    // StateObject for managing the state of the view
    @StateObject var state = StateModel()
    
    // Environment variable for dismissing the view
    @Environment(\.dismiss) var dismiss
    
    // State variable for storing the word
    @State var word: String = ""
    
    let bwl = Color("BWLColor")
    let wwl = Color("WWLColor")
    
    var body: some View {
        if !state.error { // Check if there is no error
            if state.fetched { // Check if the word is fetched
                VStack {
                    // Display GameView if playing
                    if state.playing {
                        GameView(word: word, state: state) // Display GameView
                    }
                    // Display NextLevelView if not playing
                    else {
                        
                        NextLevelView(state: state, word: word) // Display NextLevelView
                            .transition(.push(from: .trailing)) // Slide in from the right
                            .animation(.easeInOut) // Apply animation
                        
                    }
                }
                .transition(.push(from: .trailing)) // Slide in from the right
                .animation(.easeInOut) // Apply animation
                .onReceive(state.$end) { end in // Listen for end state
                    if end {
                        dismiss() // Dismiss view when the game ends
                    }
                }
            } else {
                // Display while fetching new word
                
                // todo hangman animation
                VStack {
                    Text("Fetching new word") // Display fetching message
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(bwl)
                        .onAppear {
                            fetchWord() // Fetch new word when the view appears
                        }
                    
                    ProgressView() // Display progress indicator
                        .padding()
                }
                .padding()
            }
        } else {
            // Display in case of error fetching word
            VStack {
                Text("An error occurred while fetching") // Display error message
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(bwl)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 60)
                
                Text("Try again") // Retry button
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(wwl)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(bwl)
                    .cornerRadius(20)
                    .shadow(color: bwl.opacity(0.5), radius: 10, x: 0, y: 5)
                    .onTapGesture {
                        state.error = false // Retry fetching on tap
                    }
            }
            .padding()
        }
    }
    
    // Function to fetch a new word
    private func fetchWord() {
        let url = URL(string: "https://api.api-ninjas.com/v1/randomword")!
        var request = URLRequest(url: url)
        request.setValue("IDtDFyzlyFp9TLnAkJny4A==TOnB6Kfq6EV9JlU0", forHTTPHeaderField: "X-Api-Key")
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async { // Perform UI updates on the main thread
                    state.error = true // Set error state if data is not available
                }
                return
            }
            do {
                // Try to decode the JSON data
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                
                // Check if the JSON has a "word" key and extract its value
                if let jsonWord = json?["word"] as? String {
                    // Update the word variable with the extracted word
                    DispatchQueue.main.async { // Perform UI updates on the main thread
                        word = jsonWord
                        print(word)
                        state.fetched = true // Set fetched state to true
                    }
                } else {
                    print("Failed to extract word from JSON")
                    DispatchQueue.main.async { // Perform UI updates on the main thread
                        state.error = true // Set error state if word extraction fails
                    }
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
                DispatchQueue.main.async { // Perform UI updates on the main thread
                    state.error = true // Set error state if JSON decoding fails
                }
            }
        }
        task.resume()
    }
}

// Preview for PlayControllerView
#Preview {
    PlayControllerView()
}
