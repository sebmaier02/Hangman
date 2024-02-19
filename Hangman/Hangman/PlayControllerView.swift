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
        if !state.error {
            if state.fetched {
                VStack {
                    if state.playing {
                        GameView(word: word, state: state)
                    }
                    else {
                        NextLevelView(state: state, word: word)
                    }
                }
                .onReceive(state.$end) { end in
                    if end {
                        dismiss()
                    }
                }
            } else {
                Text("Fetching new word")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .onAppear {
                        fetchWord()
                    }
                ProgressView()
                    .padding()
            }
        } else {
            VStack {
                Text("An error accured while Fetching")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 60)
                
                Text("Try again")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 5)
                    .onTapGesture {
                        state.error.toggle()
                    }
            }
            .padding()
        }
    }
    
    private func fetchWord() {
        let url = URL(string: "https://api.api-ninjas.com/v1/randomword")!
        var request = URLRequest(url: url)
        request.setValue("IDtDFyzlyFp9TLnAkJny4A==TOnB6Kfq6EV9JlU0", forHTTPHeaderField: "X-Api-Key")
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async { // Perform UI updates on the main thread
                    self.state.error.toggle()
                }
                return
            }
            do {
                // Try to decode the JSON data
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                
                // Check if the JSON has a "word" key and extract its value
                if let word = json?["word"] as? String {
                    // Update the word variable with the extracted word
                    DispatchQueue.main.async { // Perform UI updates on the main thread
                        self.word = word
                        self.state.fetched.toggle()
                        print(self.word)
                    }
                } else {
                    print("Failed to extract word from JSON")
                    DispatchQueue.main.async { // Perform UI updates on the main thread
                        self.state.error.toggle()
                    }
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
                DispatchQueue.main.async { // Perform UI updates on the main thread
                    self.state.error.toggle()
                }
            }
        }
        task.resume()
    }
}

#Preview {
    PlayControllerView()
}
