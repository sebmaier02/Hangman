import SwiftUI
import Firebase

class FetchWord {
    let db = Firestore.firestore()
    
    func fetchDocumentData(completion: @escaping ([[String]]) -> Void) {
        let docRef = db.collection("HangmanWordsEng").document("L0ZwaAhwIRlsGarFj0zT")
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if let data = document.data() as? [String: [String]] {
                    var wordArray: [[String]] = Array(repeating: [], count: 7)
                    
                    if let array = data["animal"] {
                        print("Animals: \(array)")
                        wordArray[0] = array
                    }
                    
                    if let array = data["movie"] {
                        print("Movies: \(array)")
                        wordArray[1] = array
                    }
                    
                    if let array = data["geography"] {
                        print("Geography: \(array)")
                        wordArray[2] = array
                    }
                    
                    if let array = data["sport"] {
                        print("Sport: \(array)")
                        wordArray[3] = array
                    }
                    
                    if let array = data["food"] {
                        print("Food: \(array)")
                        wordArray[4] = array
                    }
                    
                    if let array = data["song"] {
                        print("Songs: \(array)")
                        wordArray[5] = array
                    }
                    
                    if let array = data["celebrities"] {
                        print("Celebrities: \(array)")
                        wordArray[6] = array
                    }
                    
                    // Hier ähnlich für andere Kategorien
                    
                    completion(wordArray)
                } else {
                    print("Document data is not in expected format")
                    completion([])
                }
            } else {
                print("Document does not exist or failed to fetch: \(error?.localizedDescription ?? "Unknown error")")
                completion([])
            }
        }
    }
}
