//
//  CatergoryView.swift
//  Hangman
//
//  Created by Sebastian Maier on 22.04.24.
//

import SwiftUI

struct CategoryView: View {
    var text: Category
    
    @State var selected: Bool = false
    
    @Binding var categoriesEnabled: Bool
    @Binding var selectedCategories: [String]
    
    var left: Bool
    
    var body: some View {
        Text(text.stringValue(singular: false))
            .font(.title2)
            .foregroundStyle(selected ? .WWL : .BWL)
            .frame(height: 100)
            .frame(maxWidth: .infinity)
            .background(selected ? Color.correct : Color.gray.opacity(0.3))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: .BWL.opacity(selected ? 0.2 : 0), radius: 10, x: 0, y: 5)
            .onTapGesture {
                if categoriesEnabled {
                    if !selected {
                        withAnimation {
                            selected = true
                        }
                        selectedCategories.append(text.stringValue(singular: true))
                    } else {
                        withAnimation {
                            selected = false
                        }
                        selectedCategories.removeAll { $0 == text.stringValue(singular: true) }
                    }
                }
                print(selectedCategories)
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
