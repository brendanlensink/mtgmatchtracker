//
//  Game.swift
//  matchtracker
//
//  Created by Brendan Lensink on 2017-04-10.
//  Copyright © 2017 blensink. All rights reserved.
//

import Foundation

// MARK: Enums

enum Result: Int8 {
    case loss = 0
    case win = 1
    case draw = 2
    
    var title: String {
        switch self {
        case .loss: return "Loss"
        case .win: return "Win"
        case .draw: return "Draw"
        }
    }
}

enum Start: Int8 {
    case draw = 0
    case play = 1
    
    var title: String {
        switch self {
        case .draw: return "Draw"
        case .play: return "Play"
        }
    }
}

enum Hand: Int8 {
    case one = 1, two, three, four, five, six, seven
}

// MARK: Class Declaration

class Game {
    
    var matchID: String
    var gameNumber: Int8
    var result: Result = Result.win
    var start: Start = Start.play
    var myHand: Hand = Hand.seven
    var theirHand: Hand = Hand.seven
    var hasNotes: Bool = false
    var notes: String?
    
    init(id: String, gameNumber: Int) {
        matchID = id
        self.gameNumber = Int8(gameNumber)
    }
    
    // MARK: Helper Functions
    
    func export() -> String {
            return "000000\(gameNumber)\(result.rawValue)\(start.rawValue)\(binary(myHand.rawValue))\(binary(theirHand.rawValue))\(binary(hasNotes))"
    }
    
    func toDebugString() -> String {
        return "\(gameNumber) \(result) \(start) \(myHand) \(theirHand) \(notes)"
    }
    
    // MARK: Private Functions
    
    func binary(_ input: Int8) -> String {
        return String(input, radix: 2)
    }
    
    func binary(_ input: Bool) -> String {
        if(input) {
            return "1"
        }else {
            return "0"
        }
    }
    
}
