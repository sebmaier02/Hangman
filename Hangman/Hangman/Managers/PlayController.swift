import SwiftUI

struct PlayController: View {
    @StateObject var state = StateModel()
    
    @State var word: String = ""
    @State var showWarning: Bool = false
    @State var showInfo: Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            if !state.error {
                if state.fetched {
                    if state.playing {
                        GameView(state: state, word: word)
                    } else {
                        NextLevelView(state: state, word: word)
                    }
                } else {
                    FetchingView(state: state, word: $word)
                }
            } else {
                FetchingErrorView(state: state)
            }
        }
        .onReceive(state.$end) { end in
            if end {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    showWarning.toggle()
                }) {
                    Text("\(Image(systemName: "chevron.left"))")
                        .fontWeight(.bold)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showInfo.toggle()
                } label: {
                    Image(systemName: "info.circle")
                }
            }
        })
        .alert("Loosing Points", isPresented: $showWarning) {
            Button {
                state.end.toggle()
            } label: {
                Text("Leave")
                    .foregroundStyle(.red)
            }
            
            Button {
                showWarning.toggle()
            } label: {
                Text ("Stay")
                    .foregroundStyle(.green)
            }
        } message: {
            Text("If you leave your current score and streak will not be saved.")
                .font(.title2)
                .foregroundColor(.BWL)
                .multilineTextAlignment(.center)
        }
        .alert("Point System", isPresented: $showInfo) {
            Button {
                
            } label: {
                Text("OK")
                    .font(.title2)
                    .foregroundStyle(.BWL)
            }
        } message: {
            Text("Starting with 100 points, each incorrect guess deducts 10 points. However, correctly guessing the word propels you to the next round with a 10% point increase. For instance, reaching the second round boosts your starting points to 110.")
                .font(.title2)
                .foregroundColor(.BWL)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    PlayController()
}
