//
//  CatergoryView.swift
//  Hangman
//
//  Created by Sebastian Maier on 22.04.24.
//

import SwiftUI

struct CategoryView: View {
    var text: String
    
    @State var selected: Bool = false
    
    @Binding var categoriesEnabled: Bool
    
    var left: Bool
    
    var body: some View {
        Text(text)
            .font(.title2)
            .foregroundStyle(.BWL)
            .frame(height: 100)
            .frame(maxWidth: .infinity)
            .background(selected ? Color.correct.opacity(0.3) : Color.gray.opacity(0.3))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .onTapGesture {
                if categoriesEnabled {
                    selected.toggle()
                }
            }
            .onChange(of: categoriesEnabled) {
                if !categoriesEnabled {
                    if selected {
                        selected.toggle()
                    }
                }
            }
            .padding(.leading, left ? 0 : 4)
            .padding(.trailing, left ? 4 : 0)
    }
}
