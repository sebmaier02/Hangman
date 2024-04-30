import Foundation

class StateModel: ObservableObject {
    @Published var playing: Bool = false
    
    @Published var score: Double = 0
    
    @Published var gameover: Bool = false
    
    @Published var end: Bool = false
    
    @Published var fetched: Bool = false
    
    @Published var error: Bool = false
    
    @Published var streak: Double = 0
    
    @Published var prepareWord: Bool = true
}
