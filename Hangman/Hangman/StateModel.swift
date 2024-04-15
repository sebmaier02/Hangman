import Foundation

class StateModel: ObservableObject {
    // Indicates whether the game is currently being played
    @Published var playing: Bool = true
    
    // Tracks the score of the player
    @Published var score: Double = 0
    
    // Indicates whether the game is over
    @Published var gameover: Bool = false
    
    // Indicates whether the game has ended entirely
    @Published var end: Bool = false
    
    // Indicates whether the word has been fetched for the game
    @Published var fetched: Bool = false
    
    // Indicates whether an error occurred during fetching or processing the word
    @Published var error: Bool = false
    
    @Published var streak: Double = 0
}
