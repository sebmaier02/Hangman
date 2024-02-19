//
//  StateModel.swift
//  Hangman
//
//  Created by Sebastian Maier on 19.02.24.
//

import Foundation

class StateModel: ObservableObject {
    @Published var playing = true
    @Published var score = 0
    @Published var gameover = false
    @Published var end = false
}
