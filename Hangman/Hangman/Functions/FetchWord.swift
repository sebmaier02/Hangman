//
//  FetchWord.swift
//  Hangman
//
//  Created by Sebastian Maier on 22.04.24.
//

import SwiftUI
import Firebase

class FirestoreDataModel: ObservableObject {
  // First, ensure you have a Firestore instance initialized:
  let db = Firestore.firestore()

  func fetchDocumentData() {
      // Define the path to your specific document
      let docRef = db.collection("HangmanWordsEng").document("LOZwaAhwIRlsGarFj0zT")

      docRef.getDocument { (document, error) in
          if let document = document, document.exists {
              // The data will be a Dictionary with keys of type String and values of type [String]
              if let data = document.data() as? [String: [String]] {
                  // Here you have your data in the format: ["animal": ["dog", "cat", ...], "celebrities": ["elvis presley", ...], ...]
                  print("Document data: \(data)")

                  // For example, to get the array of animals:
                  if let animals = data["animal"] {
                      print("Animals: \(animals)")
                  }

                  // Do similar for other categories
              } else {
                  print("Document data is not in expected format")
              }
          } else {
              print("Document does not exist or failed to fetch: \(error?.localizedDescription ?? "Unknown error")")
          }
      }
  }
}



//import SwiftUI
//
//struct FetchWord {
//    @ObservedObject var state: StateModel
//    @Binding var word: String
//    
//    func new() {
//        let url = URL(string: "https://api.api-ninjas.com/v1/randomword")!
//        var request = URLRequest(url: url)
//        request.setValue("IDtDFyzlyFp9TLnAkJny4A==TOnB6Kfq6EV9JlU0", forHTTPHeaderField: "X-Api-Key")
//        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
//            guard let data = data else {
//                DispatchQueue.main.async {
//                    state.error = true
//                }
//                return
//            }
//            do {
//                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//                
//                if let jsonWord = json?["word"] as? String {
//                    DispatchQueue.main.async {
//                        word = jsonWord
//                        print(word)
//                        state.fetched = true
//                    }
//                } else {
//                    print("Failed to extract word from JSON")
//                    DispatchQueue.main.async {
//                        state.error = true
//                    }
//                }
//            } catch {
//                print("Error decoding JSON: \(error.localizedDescription)")
//                DispatchQueue.main.async {
//                    state.error = true
//                }
//            }
//        }
//        task.resume()
//    }
//
//}
