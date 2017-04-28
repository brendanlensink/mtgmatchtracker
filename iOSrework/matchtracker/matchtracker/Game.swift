//
//  Game.swift
//  matchtracker
//
//  Created by Brendan Lensink on 2017-04-10.
//  Copyright © 2017 blensink. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: Game Enums

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

// MARK: Class Object

class Game: Object {
    let gameNumber = RealmOptional<Int8>()
    let result = RealmOptional<Int8>()
    let start = RealmOptional<Int8>()
    let myHand = RealmOptional<Int8>()
    let theirHand = RealmOptional<Int8>()
    dynamic var notes: String?
}
