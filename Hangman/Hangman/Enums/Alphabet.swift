//
//  Alphabet.swift
//  Hangman
//
//  Created by Sebastian Maier on 22.04.24.
//

import SwiftUI

enum Alphabet {
    case alphabet1
    case alphabet2
    case alphabet3
    case alphabet4
    
    var letters: [Character] {
        switch self {
        case .alphabet1:
            return Array("ABCDEF")
        case .alphabet2:
            return Array("GHIJKLM")
        case .alphabet3:
            return Array("NOPQRS")
        case .alphabet4:
            return Array("TUVWXYZ")
        }
    }
}
