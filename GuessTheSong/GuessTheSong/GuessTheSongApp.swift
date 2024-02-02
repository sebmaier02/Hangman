//
//  GuessTheSongApp.swift
//  GuessTheSong
//
//  Created by Sebastian Maier on 18.01.24.
//

import SwiftUI

@main
struct GuessTheSongApp: App {
    var body: some Scene {
        WindowGroup {
            GameView(rounds: 20)
        }
    }
}
