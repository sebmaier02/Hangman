//
//  StartGameview.swift
//  GuessTheSong
//
//  Created by Sebastian Maier on 02.02.24.
//

import SwiftUI

struct StartGameView: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("highscore") var highscore: Int = 0
    
    let bwl = Color("BWLColor")
    let wwl = Color("WWLColor")
    
    var body: some View {
        VStack (alignment: .center) {
            
            Spacer()
            
            Text("Rules")
                .font(.largeTitle)
                .foregroundStyle(bwl)
                .padding(.bottom, 20)
            
            VStack {
                Text("In this mode you will get a random english word.")
                Text("By guessing the characters you will either get one step closer to the right answer, or one step closer to \"hangman\".")
                Text("Now go on and reach for the stars!")
            }
            .padding()
            .background(Color.gray.opacity(0.3))
            .clipShape(.rect(cornerRadius: 20))
            .font(.title2)
            .foregroundColor(bwl)
            .multilineTextAlignment(.center)
            
            Spacer()
            
            Text("Highscore: \(highscore)")
                .font(.largeTitle)
                .foregroundStyle(bwl)
                .padding(.bottom)
            
            Spacer()
            
            NavigationLink{
                PlayControllerView()
            } label: {
                Text("Start Game")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(.semibold)
                    .foregroundStyle(wwl)
                    .padding()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .background(bwl)
                    .clipShape(.rect(cornerRadius: 20))
                    .shadow(color: bwl.opacity(0.5), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y: 5)
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    StartGameView()
}
