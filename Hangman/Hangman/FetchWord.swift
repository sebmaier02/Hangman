//
//  FetchWord.swift
//  Hangman
//
//  Created by Sebastian Maier on 22.04.24.
//

import SwiftUI

struct FetchWord {
    @ObservedObject var state: StateModel
    @Binding var word: String
    
    func new() {
        let url = URL(string: "https://api.api-ninjas.com/v1/randomword")!
        var request = URLRequest(url: url)
        request.setValue("IDtDFyzlyFp9TLnAkJny4A==TOnB6Kfq6EV9JlU0", forHTTPHeaderField: "X-Api-Key")
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    state.error = true
                }
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                
                if let jsonWord = json?["word"] as? String {
                    DispatchQueue.main.async {
                        word = jsonWord
                        print(word)
                        state.fetched = true
                    }
                } else {
                    print("Failed to extract word from JSON")
                    DispatchQueue.main.async {
                        state.error = true
                    }
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    state.error = true
                }
            }
        }
        task.resume()
    }

}
