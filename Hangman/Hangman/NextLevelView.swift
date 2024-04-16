import SwiftUI

struct NextLevelView: View {
    @ObservedObject var state: StateModel
    
    @AppStorage("highscore") var highscore: Double = 0
    @AppStorage("streak") var streak: Double = 0
    
    @State var showWarning: Bool = false
    
    var word: String
    
    var body: some View {
        VStack {
            if !state.gameover {
                Spacer()
                
                Text("Well done!")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.BWL)
                
                Spacer()
                
                Image(uiImage: .happyFace)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .padding(.horizontal, 120)
                
                Spacer()
                
                Text("Streak: \(String(format: "%.0f", state.streak))")
                    .font(.largeTitle)
                    .foregroundStyle(.BWL)
                    .bold()
                
                Text("Points: \(String(format: "%.0f", state.score))")
                    .font(.largeTitle)
                    .foregroundStyle(.BWL)
                    .bold()
                
                Spacer()
                
                Text("Next")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(.semibold)
                    .foregroundStyle(.WWL)
                    .padding()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .background(.BWL)
                    .clipShape(.rect(cornerRadius: 20))
                    .shadow(color: .BWL.opacity(0.5), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y: 5)
                    .padding(.horizontal, 70)
                    .onTapGesture {
                        state.fetched.toggle()
                        state.playing.toggle()
                    }
                
                Spacer()
            } else {
                Spacer()
                
                Text("The word was:")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.BWL)
                
                Text(word.uppercased())
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.BWL)
                
                Spacer()
                
                Image(uiImage: .sadFace)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .padding(.horizontal, 120)
                
                Spacer()
                
                Text("Streak: \(String(format: "%.0f", state.streak))")
                    .font(.largeTitle)
                    .foregroundStyle(.BWL)
                    .bold()
                
                Text("Final points: \(String(format: "%.0f", state.score))")
                    .font(.largeTitle)
                    .foregroundStyle(.BWL)
                    .bold()
                
                Spacer()
                
                if state.score > highscore {
                    Text("New Highscore!!!")
                        .font(.largeTitle)
                        .foregroundStyle(.BWL)
                        .bold()
                }
                
                Spacer()
                
                Text("End game")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(.semibold)
                    .foregroundStyle(.WWL)
                    .padding()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .background(.BWL)
                    .clipShape(.rect(cornerRadius: 20))
                    .shadow(color: .BWL.opacity(0.5), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y: 5)
                    .padding(.horizontal, 70)
                    .onTapGesture {
                        if state.score > highscore {
                            highscore = state.score
                        }
                        
                        if state.streak > streak {
                            streak = state.streak
                        }
                        
                        state.end.toggle()
                    }
                
                Spacer()
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
}
