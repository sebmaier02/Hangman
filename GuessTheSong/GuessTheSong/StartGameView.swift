//
//  StartGameview.swift
//  GuessTheSong
//
//  Created by Sebastian Maier on 02.02.24.
//

import SwiftUI

struct StartGameView: View {
    var mode: String
    @State var rounds: Int = 0
    var description: String
    
    var body: some View {
        NavigationStack {
            Text(description)
            
            NavigationLink(destination: GameView(rounds: rounds)) {
                Text("Start")
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
        .padding()
        .onAppear {
            if mode == "Quick" {
                rounds = 10
            } else if mode == "Medium" {
                rounds = 20
            } else if mode == "Infinity" {
                rounds = -1
            } else {
                rounds = 10
            }
        }
    }
}

#Preview {
    StartGameView(mode: "Quick", description: "lol")
}
