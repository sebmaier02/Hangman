//
//  StateModel.swift
//  Hangman
//
//  Created by Sebastian Maier on 19.02.24.
//

import Foundation

class StateModel: ObservableObject {
    @Published var playing: Bool = true
    @Published var score: Int = 0
    @Published var gameover: Bool = false
    @Published var end: Bool = false
    @Published var fetched: Bool = false
}
