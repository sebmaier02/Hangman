//
//  FetchingView.swift
//  Hangman
//
//  Created by Sebastian Maier on 22.04.24.
//

import SwiftUI

struct FetchingView: View {
    @ObservedObject var state: StateModel
    
    @Binding var word: String
    
    var body: some View {
        VStack {
            Text("Fetching new word")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.BWL)
            
            ProgressView()
                .padding()
        }
        .onAppear {
            FetchWord(state: state, word: $word).new()
        }
        .padding(.horizontal)
        .navigationBarBackButtonHidden(true)
    }
}
