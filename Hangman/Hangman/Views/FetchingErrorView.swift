//
//  FetchingErrorView.swift
//  Hangman
//
//  Created by Sebastian Maier on 22.04.24.
//

import SwiftUI

struct FetchingErrorView: View {
    @ObservedObject var state: StateModel
    
    @State var showWarning: Bool = false
    
    var body: some View {
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
}
