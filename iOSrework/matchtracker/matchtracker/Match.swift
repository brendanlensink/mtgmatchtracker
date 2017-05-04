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
    let rGames = List<Game>()
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
    
    // TODO: Figure out if/what I want to index

    // TODO: This can be better
    func storeGames() {
        for game in games {
            if let game = game { rGames.append(game) }
        }
    }
    
    // MARK: Helper Functions
    
    func getResult() -> String {
        var numWins = 0
        var numLosses = 0
        var numDraws = 0
        
        for game in rGames {
            if let result = game.result.value {
                switch Int(result) {
                case 0: numLosses += 1
                case 1: numWins += 1
                case 2: numDraws += 1
                default: break
                }
            }
        }
        return "\(numWins)-\(numLosses)"
    }
    
    func toCSV() -> String {
        var returnString = ""
        if let id = matchID { returnString += "\(id)," } else { returnString += "," }
        if let created = created { returnString += "\(created)," } else { returnString += "," }
        if let name = name { returnString += "\(name)," } else { returnString += "," }
        if let format = format { returnString += "\(format)," } else { returnString += "," }
        if let rel = rel { returnString += "\(rel)," } else { returnString += "," }
        if let myDeck = myDeck { returnString += "\(myDeck)," } else { returnString += "," }
        if let theirDeck = theirDeck { returnString += "\(theirDeck)," } else { returnString += "," }
        
        for game in rGames {
            returnString += game.toCSV()
        }
        return returnString + "\n"
    }
}


