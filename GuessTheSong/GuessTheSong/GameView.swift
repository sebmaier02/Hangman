//
//  GameView.swift
//  GuessTheSong
//
//  Created by Tobias Pummer on 01.02.24.
//

import SwiftUI

struct GameView: View {
    var rounds: Int
    @State var roundsPlayed: Int = 0
    @State var score: Int = 0
    @State var scoreThisRound: Int = 0
    @State var songName: String = ""
    @State var interpret: String = ""
    @State var isPlaying: Bool = true
    @State var submitted: Bool  = false
    @State var infinityRound: Bool = false
    @State var end: Bool = false
    @Environment(\.dismiss) var dismiss
    @AppStorage("highscoreQuick") var highscoreQuick: Int = 0
    @AppStorage("highscoreMedium") var highscoreMedium: Int = 0
    @AppStorage("highscoreInfinity") var highscoreInfinity: Int = 0
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .center){
                if isPlaying && !submitted {
                    VStack {
                        Text("Listen").font(.system(size: 100))
                    }
                    .padding()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            isPlaying.toggle()
                        }
                        roundsPlayed+=1
                    }
                } else {
                    if !submitted {
                        VStack {
                            Spacer()
                            
                            Text("Please enter your answer")
                                .font(.title)
                                .padding(.bottom, 50)
                            
                            formTextField(titel: "Title", placeholder: "title", value: $songName)
                            
                            formTextField(titel: "Interpret", placeholder: "interpret", value: $interpret)
                            
                            Button(action: {
                                submitted.toggle()
                            }) {
                                Text("Submit")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue)
                                    .cornerRadius(20)
                                    .shadow(color: Color.blue.opacity(0.5), radius: 10, x: 0, y: 5)
                            }
                            .padding(.top, 50)
                            
                            Spacer()
                        }
                        .padding()
                        .onAppear {
                            songName = ""
                            interpret = ""
                        }
                    } else {
                        VStack (spacing: 30) {
                            Spacer()
                            Text("Your Answer").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            
                            Text("Title: " + songName).font(.title2)
                            Text("Interpret: " + interpret).font(.title2)
                            
                            Spacer()
                            
                            Text("Correct Awnser").font(.title)
                            Text("Title: xxx" ).font(.title2)
                            Text("Interpret: xxx").font(.title2)
                            
                            Spacer()
                            
                            if scoreThisRound == 100 {
                                Group {
                                    Text("WOW you earned 100 points!!!")
                                    Text("Your new score is \(score)")
                                }
                            } else if scoreThisRound == 50 {
                                Text("You earned 50 points")
                                Text("Your new score is \(score)")
                            } else {
                                Text("Maybe you should practice first.")
                                Text("Score is still at \(score)")
                            }
                            
                            if end {
                                Spacer()
                                Button(action: {
                                    if rounds == 10 {
                                        highscoreQuick = score
                                    } else if rounds == 20 {
                                        highscoreMedium = score
                                    } else if rounds == -1 {
                                        highscoreInfinity = score
                                    }
                                    dismiss()
                                }) {
                                    Text("End game")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(Color.blue)
                                        .cornerRadius(20)
                                        .shadow(color: Color.blue.opacity(0.5), radius: 10, x: 0, y: 5)
                                }
                            }
                            
                            Spacer()
                        }
                        .padding()
                        .onAppear{
                            if songName == "xxx" && interpret == "xxx" {
                                score += 100;
                                scoreThisRound = 100;
                            } else if songName == "xxx" || interpret == "xxx" {
                                score += 50;
                                scoreThisRound = 50;
                            } else {
                                scoreThisRound = 0;
                                if infinityRound {
                                    end = true
                                }
                            }
                            
                            if roundsPlayed == rounds && !infinityRound {
                                end = true
                            }
                            
                            if !end {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                    isPlaying.toggle()
                                    submitted.toggle()
                                }
                            }
                        }
                    }
                }
            }
            .toolbar{
                ToolbarItem(placement: .principal) {
                    if infinityRound {
                        Text("Round: \(roundsPlayed)")
                            .padding()
                            .foregroundStyle(Color.white)
                            .font(.title3)
                            .padding(.trailing, 5)
                            .background(Color.blue)
                            .cornerRadius(20)
                            .shadow(color: Color.blue.opacity(0.5), radius: 10, x: 0, y: 5)
                            .padding(.top, 80)
                    } else {
                        Text("Round: \(roundsPlayed) of \(rounds)")
                            .padding()
                            .foregroundStyle(Color.white)
                            .font(.title3)
                            .padding(.trailing, 5)
                            .background(Color.blue)
                            .cornerRadius(20)
                            .shadow(color: Color.blue.opacity(0.5), radius: 10, x: 0, y: 5)
                            .padding(.top, 80)
                    }
                }
            }
        }
        .onAppear{
            if rounds < 0 {
                infinityRound = true
            }
        }
    }
    
    private struct formTextField: View {
        var titel: String
        var placeholder: String
        @Binding var value: String
        
        var body: some View {
            VStack(alignment: .leading) {
                Text(titel)
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(Color(.darkGray))
                TextField(placeholder, text: $value)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .padding(.horizontal)
                    .padding(10)
                    .overlay (
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color(.systemGray5), lineWidth: 1)
                    )
                    .padding(.vertical, 10)
            }
            .padding()
        }
    }
}

#Preview {
    GameView(rounds: -1)
}
