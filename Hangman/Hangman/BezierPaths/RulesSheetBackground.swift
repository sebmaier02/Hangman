//
//  RulesSheetBackground.swift
//  Hangman
//
//  Created by Sebastian Maier on 22.04.24.
//

import SwiftUI

struct RulesSheetBackground: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.height))
            path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.height), control: CGPoint(x: rect.midX, y: rect.height*1.5))
        }
    }
}
