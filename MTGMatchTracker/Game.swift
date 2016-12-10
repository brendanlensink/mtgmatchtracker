//
//  Game.swift
//  MTGMatchTracker
//
//  Created by Brendan Lensink on 2016-11-17.
//  Copyright © 2016 blensink. All rights reserved.
//

import CoreData
import ReactiveSwift
import enum Result.NoError

class Game {
  let start: Start
  let result: GameResult
  let myHand: Hand
  let theirHand: Hand
  let notes: String?
  
  /**
   *  Make a new game with the provided values
   *
   *  - Parameters:
   *    - start: The user's start, either play or draw
   *    - result: The game result
   *    - myHand: User's starting hand size
   *    - theirHand: Opp's starting hand size
   *    - notes: Any notes taken during match
   */
  init(start: Start, result: GameResult, myHand: Hand, theirHand: Hand, notes: String?) {
    self.start = start
    self.result = result
    self.myHand = myHand
    self.theirHand = theirHand
    self.notes = notes
  }
  
  func toString() -> String {
    return "Start: \(start), \n Result: \(result) \n My Hand: \(myHand) \n Their hand: \(theirHand) Notes: \(notes)"
  }
}

/**
 *  User's start value
 */
enum Start: String {
  case play = "Play"
  case draw = "Draw"
  
  static let allValues = [play, draw]
}

/**
 *  The final result of a game
 */
enum GameResult: String {
  case w = "Win"
  case l = "Loss"
  
  static let allValues = [w, l]
}

/**
 *  Possible hand sizes for a game
 */
enum Hand: Int {
  case one = 1
  case two
  case three
  case four
  case five
  case six
  case seven
  
  static let allValues = [seven, six, five, four, three, two, one]
}
