//
//  Categorys.swift
//  Hangman
//
//  Created by Sebastian Maier on 18.04.24.
//

import Foundation

enum Category: CaseIterable {
    case animals
    case movies
    case geography
    case sport
    case food
    case songs
    case celebrities
    
    func stringValue(singular: Bool) -> String {
        switch self {
        case .animals:
            return singular ? "animal" : "Animals"
        case .movies:
            return singular ? "movie" : "Movies"
        case .geography:
            return singular ? "geography" : "Geography"
        case .sport:
            return singular ? "sport" : "Sports"
        case .food:
            return singular ? "food" : "Foods"
        case .songs:
            return singular ? "song" : "Songs"
        case .celebrities:
            return singular ? "celebrity" : "Celebrities"
        }
    }
    
    static var allCasesSingular: [String] {
        return allCases.map { $0.stringValue(singular: true) }
    }
    
    static var allCasesPlural: [String] {
        return allCases.map { $0.stringValue(singular: false) }
    }
}


