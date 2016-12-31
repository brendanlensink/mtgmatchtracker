//
//  Game.swift
//  MTGMatchTracker
//
//  Created by Brendan Lensink on 2016-11-17.
//  Copyright © 2016 blensink. All rights reserved.
//

import CoreData
import RealmSwift
import ReactiveSwift
import enum Result.NoError

class Game: Object {
  dynamic var matchID: String = ""
  dynamic var game: Int = 0
  dynamic var start: Int8 = 0
  dynamic var result: Int8 = 0
  dynamic var myHand: Int8 = 0
  dynamic var theirHand: Int8 = 0
  dynamic var notes: String = ""
}

/**
 *  User's start value
 */
enum Start: Int8 {
  case play = 0
  case draw = 1
}

/**
 *  The final result of a game
 */
enum GameResult: Int8 {
  case w = 0
  case l = 1
}

/**
 *  Possible hand sizes for a game
 */
enum Hand: Int8 {
  case one = 1
  case two
  case three
  case four
  case five
  case six
  case seven
  
  static let allValues = [seven, six, five, four, three, two, one]
}
