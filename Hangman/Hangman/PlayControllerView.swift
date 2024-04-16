import SwiftUI

struct PlayControllerView: View {
    @StateObject var state = StateModel()
    
    @State var word: String = ""
    @State var showWarning: Bool = false
    
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
                fetchNewWordView
            }
        } else {
            errorView
        }
    }
    
    var fetchNewWordView: some View {
        VStack {
            Text("Fetching new word")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.BWL)
            
            ProgressView()
                .padding()
        }
        .onAppear {
            fetchWord()
        }
        .padding(.horizontal)
        .navigationBarBackButtonHidden(true)
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    showWarning.toggle()
                }) {
                    Text("\(Image(systemName: "chevron.left"))")
                        .fontWeight(.bold)
                }
                .alert("Loosing Points", isPresented: $showWarning) {
                    HStack {
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
                    }
                } message: {
                    Text("If you leave your current score and streak will not be saved.")
                        .font(.title2)
                        .foregroundColor(.BWL)
                        .multilineTextAlignment(.center)
                }
            }
        })
    }
    
    var errorView: some View {
        VStack {
            Text("An error occurred while fetching") // Display error message
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.BWL)
                .multilineTextAlignment(.center)
                .padding(.bottom, 60)
            
            Text("Try again") // Retry button
                .font(.title)
                .bold()
                .foregroundColor(.WWL)
                .padding()
                .frame(maxWidth: .infinity)
                .background(.BWL)
                .cornerRadius(20)
                .shadow(color: .BWL.opacity(0.5), radius: 10, x: 0, y: 5)
                .onTapGesture {
                    state.error = false // Retry fetching on tap
                }
        }
        .padding(.horizontal)
        .navigationBarBackButtonHidden(true)
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    showWarning.toggle()
                }) {
                    Text("\(Image(systemName: "chevron.left"))")
                        .fontWeight(.bold)
                }
                .alert("Loosing Points", isPresented: $showWarning) {
                    HStack {
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
                    }
                } message: {
                    Text("If you leave your current score and streak will not be saved.")
                        .font(.title2)
                        .foregroundColor(.BWL)
                        .multilineTextAlignment(.center)
                }
            }
        })
    }
    
    private func fetchWord() {
        let url = URL(string: "https://api.api-ninjas.com/v1/randomword")!
        var request = URLRequest(url: url)
        request.setValue("IDtDFyzlyFp9TLnAkJny4A==TOnB6Kfq6EV9JlU0", forHTTPHeaderField: "X-Api-Key")
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    state.error = true
                }
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                
                if let jsonWord = json?["word"] as? String {
                    DispatchQueue.main.async {
                        word = jsonWord
                        print(word)
                        state.fetched = true
                    }
                } else {
                    print("Failed to extract word from JSON")
                    DispatchQueue.main.async {
                        state.error = true
                    }
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    state.error = true
                }
            }
        }
        task.resume()
    }
}

#Preview {
    PlayControllerView()
}
