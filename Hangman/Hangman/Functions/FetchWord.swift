import SwiftUI
import Firebase

class FetchWord {
    let db = Firestore.firestore()
    
    func fetchDocumentData(for categories: [String], completion: @escaping ([[String]]) -> Void) {
        let docRef = db.collection("HangmanWordsEng").document("L0ZwaAhwIRlsGarFj0zT")
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if let data = document.data() as? [String: [String]] {
                    var wordArray: [[String]] = Array(repeating: [], count: 0)
                    
                    for category in categories {
                        if let array = data[category] {
                            wordArray.append(array)
                        }
                    }
                    
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
