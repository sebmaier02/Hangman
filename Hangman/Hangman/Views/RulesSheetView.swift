//
//  RulesSheetView.swift
//  Hangman
//
//  Created by Sebastian Maier on 22.04.24.
//

import SwiftUI

struct RulesSheetView: View {
    
    @Binding var showInfo: Bool
    
    var body:some View {
        NavigationView {
            VStack {
                VStack {
                    Text("Rules")
                        .font(.largeTitle)
                        .foregroundStyle(.WWL)
                        .bold()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(RulesSheetBackground().foregroundStyle(.BWL).ignoresSafeArea(edges: .top))
                
                Spacer(minLength: 100)
                
                VStack {
                    Text("In this mode, you'll receive a random English word. Each character you guess brings you either closer to the correct answer or closer to revealing the 'hangman'. Now, aim high and reach for the stars!")
                        .padding()
                        .background(.gray.opacity(0.3))
                        .clipShape(.rect(cornerRadius: 20))
                        .font(.title2)
                        .foregroundColor(.BWL)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Text("Starting with 100 points, each incorrect guess deducts 10 points. However, correctly guessing the word propels you to the next round with a 10% point increase. For instance, reaching the second round boosts your starting points to 110.")
                        .padding()
                        .background(.gray.opacity(0.3))
                        .clipShape(.rect(cornerRadius: 20))
                        .font(.title2)
                        .foregroundColor(.BWL)
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal)
                
                Spacer(minLength: 50)
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "xmark.circle")
                        .foregroundStyle(.WWL)
                        .onTapGesture {
                            showInfo.toggle()
                        }
                }
            }
        }
    }
}

#Preview {
    RulesSheetView(showInfo: .constant(true))
}
