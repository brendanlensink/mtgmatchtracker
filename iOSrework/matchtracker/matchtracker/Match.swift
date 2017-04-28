//
//  Match.swift
//  matchtracker
//
//  Created by Brendan Lensink on 2017-04-10.
//  Copyright © 2017 blensink. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyUserDefaults

// MARK: Match Enums

enum Format: Int8 {
    case sealed = 0
    case draft = 1
    case standard = 2
    case modern = 3
    case legacy = 4
    case edh = 5
    
    var title: String {
        switch self {
        case .sealed: return "Sealed"
        case .draft: return "Draft"
        case .standard: return "Standard"
        case .modern: return "Modern"
        case .legacy: return "Legacy"
        case .edh: return "Commander"
        }
    }
    
    static let allValues = ["Sealed", "Draft", "Standard", "Modern", "Legacy", "Commander"]
}

enum REL: Int8 {
    case casual = 0
    case competitive = 1
    case professional = 2
    
    var title: String {
        switch self{
        case .casual: return "Casual"
        case .competitive: return "Competitive"
        case .professional: return "Professional"
        }
    }
    
    static let allValues = ["Casual", "Competitive", "Professional"]
}

// MARK: Class Declaration

class Match: Object {
    private let rGames = List<Game>()
    var games: [Game?] = [nil, nil]
    
    private let rFormat = RealmOptional<Int8>()
    var format: Format? {
        get { return Format(rawValue: rFormat.value!)! }
        set { rFormat.value = newValue?.rawValue ?? nil }
    }
    
    private let rREL = RealmOptional<Int8>()
    var rel: REL? {
        get { return REL(rawValue: rREL.value!)! }
        set { rREL.value = newValue?.rawValue ?? nil }
    }

    dynamic var matchID: String?
    dynamic var created: Date?
    dynamic var name: String?
    dynamic var myDeck: String?
    dynamic var theirDeck: String?
    
    // TODO: This can be better
    func storeGames() {
        for game in games {
            if let game = game { rGames.append(game) }
        }
    }
    
    // TODO: Figure out if/what I want to index
}


