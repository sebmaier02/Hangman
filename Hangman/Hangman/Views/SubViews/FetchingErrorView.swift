//
//  FetchingErrorView.swift
//  Hangman
//
//  Created by Sebastian Maier on 22.04.24.
//

import SwiftUI

struct FetchingErrorView: View {
    @ObservedObject var state: StateModel
    
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
    }
}
