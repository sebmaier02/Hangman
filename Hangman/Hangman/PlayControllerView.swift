//
//  PlayConttrollerView.swift
//  Hangman
//
//  Created by Sebastian Maier on 19.02.24.
//

import SwiftUI

struct PlayControllerView: View{
    @StateObject var state = StateModel()
    @Environment(\.dismiss) var dismiss
    @State var word: String = ""
    
    var body: some View {
        if state.fetched {
            VStack {
                if state.playing {
                    GameView(word: word, state: state)
                }
                else {
                    NextLevelView(state: state)
                }
            }
            .onReceive(state.$end) { end in
                if end {
                    dismiss()
                }
            }
        } else {
            Text("Fetching new word")
                .onAppear {
                    fetchWord()
                }
        }
        
    }
    
    
    private func fetchWord() {
        let url = URL(string: "https://api.api-ninjas.com/v1/randomword")!
        var request = URLRequest(url: url)
        request.setValue("IDtDFyzlyFp9TLnAkJny4A==TOnB6Kfq6EV9JlU0", forHTTPHeaderField: "X-Api-Key")
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data else { return }
            do {
                // Try to decode the JSON data
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                
                // Check if the JSON has a "word" key and extract its value
                if let word = json?["word"] as? String {
                    // Update the word variable with the extracted word
                    DispatchQueue.main.async { // Perform UI updates on the main thread
                        self.word = word
                        self.state.fetched.toggle()
                    }
                    print(self.word)
                } else {
                    print("Failed to extract word from JSON")
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}

#Preview {
    PlayControllerView()
}
