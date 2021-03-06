//
//  MatchViewModel.swift
//  MatchTracker
//
//  Created by Brendan Lensink on 2017-05-06.
//  Copyright © 2017 Brendan Lensink. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyUserDefaults

class MatchViewModel {
    
    var match: Match?
    
    init(match: Match?) {
        self.match = match
    }
    
    func storeMatch(values: [String:Any]) -> (Bool, String) {
        let newMatch = Match(value: values)
        newMatch.matchID = "\(DateManager.shared.toMS(date: Date()))_\(UIDevice.current.identifierForVendor!.uuidString)"
        if let game = values["game0"] as? Game {
            game.gameNumber.value = 0
            newMatch.games.append(game)
        }
        if let game = values["game1"] as? Game {
            game.gameNumber.value = 1
            newMatch.games.append(game)
        }
        if let game = values["game2"] as? Game {
            game.gameNumber.value = 2
            newMatch.games.append(game)
        }
        let isReady = newMatch.isReady()
        if(isReady.0) {
            RealmModel.shared.saveMatch(newMatch)
            
            // Save the defaults
            Defaults[.eventName] = newMatch.name
            Defaults[.format] = Format(rawValue: newMatch.format!.lowercased())
            Defaults[.REL] = REL(rawValue: newMatch.rel!.lowercased())
            Defaults[.myDeck] = newMatch.myDeck
        }else {
            var returnString = ""
            for item in isReady.1 {
                returnString += item
            }
            return (isReady.0, returnString)
        }
        return (isReady.0, "")
    }
}
