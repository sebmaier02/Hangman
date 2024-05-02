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
                        .shadow(color: .BWL.opacity(0.5), radius: 10, x: 0, y: 5)
                }
                .frame(maxWidth: .infinity)
                .background(RulesSheetBackground().foregroundStyle(.BWL.opacity(0.4)).ignoresSafeArea(edges: .top).shadow(color: .BWL.opacity(0.5), radius: 10, x: 0, y: 5))
                
                VStack {
                    Spacer()
                    
                    Text("You'll receive a random English word. Each character you guess brings you either closer to the correct answer or closer to revealing the 'hangman'. Now, aim high and reach for the stars!")
                        .modifier(InfoTextStyle())
                    
                    Spacer()
                    
                    Text("Starting with 100 points, each incorrect guess deducts 10 points. However, correctly guessing the word propels you to the next round with a 10% point increase. For instance, reaching the second round boosts your starting points to 110.")
                        .modifier(InfoTextStyle())
                    
                    Spacer()
                }
                .padding(.horizontal)
                
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showInfo.toggle()
                    } label: {
                        Image(systemName: "xmark.circle")
                            .foregroundStyle(.WWL)
                    }
                }
            }
        }
    }
}

struct InfoTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.gray.opacity(0.3))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .font(.title2)
            .foregroundColor(.BWL)
            .multilineTextAlignment(.center)
    }
}

#Preview {
    RulesSheetView(showInfo: .constant(true))
}
