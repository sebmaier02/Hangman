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
    var body: some View {
        VStack {
            if state.playing {
                GameView(word: "lol", state: state)
            }
            else {
                NextLevelView(state: state)
            }
        }
        .onReceive(state.$end) { end in
            if end {
                dismiss()
            }
        }
    }
}

#Preview {
    PlayControllerView()
}
