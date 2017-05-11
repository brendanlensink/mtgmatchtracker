//
//  Game.swift
//  MatchTracker
//
//  Created by Brendan Lensink on 2017-05-06.
//  Copyright © 2017 Brendan Lensink. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: Game Enums

enum Result: String {
    case loss
    case win
    case draw
}

enum Start: String {
    case draw
    case play
}

enum Hand: Int8 {
    case one = 1, two, three, four, five, six, seven
}

class Game: Object {
    let gameNumber = RealmOptional<Int8>()
    dynamic var result: String? = Result.win.rawValue
    dynamic var start: String? = Start.play.rawValue
    let myHand = RealmOptional<Int8>(7)
    let theirHand = RealmOptional<Int8>(7)
    dynamic var notes: String?
    
    func toCSV() -> String {
        var returnString = ""
        if let number = gameNumber.value { returnString += "\(number)," } else { returnString += "," }
        if let result = result { returnString += "\(result)," } else { returnString += "," }
        if let start = start { returnString += "\(start)," } else { returnString += "," }
        if let myHand = myHand.value { returnString += "\(myHand)," } else { returnString += "," }
        if let theirHand = theirHand.value { returnString += "\(theirHand)," } else { returnString += "," }
        if let notes = self.notes  { returnString += "\(notes)," } else { returnString += "," }
        return returnString
    }
    
    func isReady() -> (Bool, [String]) {
        var isReady: (Bool, [String]) = (true, [])
        
        if result == nil {
            isReady.0 = false
            isReady.1.append("result")
        }
        if start == nil {
            isReady.0 = false
            isReady.1.append("start")
        }
        if myHand.value == nil {
            isReady.0 = false
            isReady.1.append("my hand")
        }
        if theirHand.value == nil {
            isReady.0 = false
            isReady.1.append("their hand")
        }
        print(self)
        
        return isReady
    }

}
