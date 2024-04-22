import SwiftUI

struct PlayControllerView: View {
    @StateObject var state = StateModel()
    
    @State var word: String = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        if !state.error {
            if state.fetched {
                VStack {
                    if state.playing {
                        GameView(word: word, state: state)
                    } else {
                        NextLevelView(state: state, word: word)
                    }
                }
                .onReceive(state.$end) { end in
                    if end {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            } else {
                FetchingView(state: state, word: $word)
            }
        } else {
            FetchingErrorView(state: state)
        }
    }
}

#Preview {
    PlayControllerView()
}
