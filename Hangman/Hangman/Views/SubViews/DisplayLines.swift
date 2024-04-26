//
//  DisplayLines.swift
//  Hangman
//
//  Created by Sebastian Maier on 22.04.24.
//

import SwiftUI

struct DisplayLines: View {
    @Binding var emptyWordCharArray: [Character]
    @Binding var wordCharArray: [Character]
    
    let underscore: UIImage = .unterstrich1
    
    var body: some View {
        HStack {
            ForEach(0..<wordCharArray.count) { index in
                VStack {
                    if wordCharArray[index] != " " {
                        Text("\(emptyWordCharArray[index])")
                            .font(Font.custom("Miology", size: 20))
                            .foregroundStyle(.white)
                            .frame(maxWidth: 20)
                            .padding(.bottom, -20)
                        
                        Image(uiImage: underscore)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 20)
                    } else {
                        Color.gray
                            .opacity(0)
                            .scaledToFit()
                            .frame(maxWidth: 20)
                    }
                }
            }
        }
        .padding(.horizontal, 40)
    }
}
