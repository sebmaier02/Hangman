//
//  SettingsView.swift
//  Hangman
//
//  Created by Sebastian Maier on 01.05.24.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("hapticFeedback") var hapticFeedback: Bool = false
    @State var haFe: Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            List {
                Section() {
                    Toggle("Haptic Feedback", isOn: $haFe)
                        .tint(.correct)
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
        .navigationBarTitle("Settings")
        .navigationBarTitleDisplayMode(.large)
        .navigationBarBackButtonHidden(true)
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("\(Image(systemName: "chevron.left.circle"))")
                }
            }
        })
        .onAppear {
            haFe = hapticFeedback
        }
        .onDisappear {
            hapticFeedback = haFe
        }
    }
}

#Preview {
    SettingsView()
}
