//
//  FetchingView.swift
//  Hangman
//
//  Created by Sebastian Maier on 22.04.24.
//

import SwiftUI

struct FetchingView: View {
    @ObservedObject var state: StateModel
    
    @Binding var wordArray: [[String]]
    
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
            FetchWord().fetchDocumentData { fetchedWordArray in
                wordArray = fetchedWordArray
                state.fetched = true
            }
        }
        .padding(.horizontal)
        .navigationBarBackButtonHidden(true)
    }
}
