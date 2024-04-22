//
//  ButtonView.swift
//  Hangman
//
//  Created by Sebastian Maier on 22.04.24.
//

import SwiftUI

struct ButtonView: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.title)
            .bold()
            .foregroundStyle(.WWL)
            .padding()
            .frame(maxWidth: .infinity)
            .background(.BWL)
            .clipShape(.rect(cornerRadius: 20))
            .shadow(color: .BWL.opacity(0.5), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y: 5)
            .padding(.horizontal, 70)
    }
}
