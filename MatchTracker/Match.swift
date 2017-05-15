//
//  Match.swift
//  MatchTracker
//
//  Created by Brendan Lensink on 2017-05-06.
//  Copyright © 2017 Brendan Lensink. All rights reserved.
//

import RealmSwift

// MARK: Match Enums

enum Format: String {
    case sealed
    case draft
    case standard
    case modern
    case legacy
    case edh
    
    static let allValues = ["Sealed", "Draft", "Standard", "Modern", "Legacy", "Commander"]
}

enum REL: String {
    case casual
    case competitive
    case professional

    static let allValues = ["Casual", "Competitive", "Professional"]
}

class Match: Object {
    dynamic var matchID: String?
    dynamic var created: Date?
    dynamic var name: String?
    dynamic var format: String?
    dynamic var rel: String?
    dynamic var myDeck: String?
    dynamic var theirDeck: String?
    let games = List<Game>()
    
    // MARK: Helper Functions
    
    func isReady() -> (Bool, [String]) {
        var isReady: (Bool, [String]) = (true, [])
        
        if name == nil {
            isReady.0 = false
            isReady.1.append("name")
        }
        if myDeck == nil {
            isReady.0 = false
            isReady.1.append("my deck")
        }
        if theirDeck == nil {
            isReady.0 = false
            isReady.1.append("their deck")
        }
        if format == nil {
            isReady.0 = false
            isReady.1.append("format")
        }
        if rel == nil {
            isReady.0 = false
            isReady.1.append("rel")
        }
        for (i, game) in games.enumerated() {
            let gameStatus = game.isReady()
            if !gameStatus.0 && i != 2 {
                isReady.0 = false
                for item in gameStatus.1 {
                    isReady.1.append("game \(i+1) \(item)")
                }
            }
        }
        return isReady
    }
    
    func getResult() -> String {
        var wins = 0
        var losses = 0
        
        for game in games {
            if game.result == Result.win.rawValue {
                wins += 1
            }else {
                losses += 1
            }
        }
        
        return "\(wins) - \(losses)"
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
        
        for game in games {
            returnString += game.toCSV()
        }
        return returnString + "\n"
    }
}
