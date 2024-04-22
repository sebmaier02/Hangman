//
//  FetchingView.swift
//  Hangman
//
//  Created by Sebastian Maier on 22.04.24.
//

import SwiftUI

struct FetchingView: View {
    @ObservedObject var state: StateModel
    
    @State var showWarning: Bool = false
    
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
