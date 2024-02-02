//
//  GameView.swift
//  GuessTheSong
//
//  Created by Tobias Pummer on 01.02.24.
//

import SwiftUI

struct GameView: View {
    private var rounds: Int = 20
    private var score = 0
    @State var songName: String = ""
    @State var interpret: String = ""
    @State var isPlaying: Bool = true
    @State var submitted: Bool  = false
    
    var body: some View {
        if isPlaying && !submitted {
            VStack {
                Text("Listen to the song").font(.title)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            isPlaying.toggle()
                        }
                    }
            }
            .padding()
        } else {
            if !submitted {
                VStack {
                    Spacer()
                    Text("Please enter your awnsers").font(.title)
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
                    
                    Spacer()
                }
                .padding()
            } else {
                VStack {
                    Text("Your Awnser")
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                isPlaying.toggle()
                                submitted.toggle()
                            }
                        }
                    
                    
                }
                .padding()
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

#Preview {
    GameView()
}
