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
    var score = 0
    @State var songName: String = ""
    @State var interpret: String = ""
    @State var isPlaying: Bool = true
    @State var submitted: Bool  = false
    @State var firstRound: Bool  = true
    
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
                        if firstRound {
                            firstRound.toggle()
                        } else {
                            roundsPlayed+=1
                        }
                    }
                } else {
                    if !submitted {
                        VStack {
                            Spacer()
                            
                            Text("Please enter your awnsers")
                                .font(.title)
                                .padding(.bottom, 50)
                            
                            formTextField(titel: "Titel", placeholder: "titel", value: $songName)
                            
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
                            Text("Your Awnser").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                        isPlaying.toggle()
                                        submitted.toggle()
                                    }
                                }
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            Text("Titel: " + songName).font(.title2)
                            Text("Interpret: " + interpret).font(.title2)
                            
                            Text("Correct Awnser").font(.title)
                            Text("Titel: xxx" ).font(.title2)
                            Text("Interpret: xxx").font(.title2)
                            
                            Spacer()
                        }
                        .padding()
                    }
                }
            }
            .toolbar{
                ToolbarItem(placement: .principal) {
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
    GameView(rounds: 10)
}

