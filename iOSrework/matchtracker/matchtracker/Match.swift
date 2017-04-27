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

// MARK: Enums

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

class Match {
    var matchID: String
    var created: Date?
    var name: String?
    var format: Format?
    var REL: REL?
    var myDeck: String?
    var theirDeck: String?
    var games: [Game?] = [nil, nil]
    
    init(id: String) {
        self.matchID = id
    }
}

// MARK: Realm Class

class RealmMatch: Object {
    dynamic var matchID: String?
    dynamic var created: Date?
    dynamic var name: String?
    let format = RealmOptional<Int8>()
    let REL = RealmOptional<Int8>()
    dynamic var myDeck: String?
    dynamic var theirDeck: String?
    let games = List<RealmGame>()
    
    // TODO: Figure out if/what I want to index
}


