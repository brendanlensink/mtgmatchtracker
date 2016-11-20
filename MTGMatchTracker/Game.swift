//
//  Game.swift
//  MTGMatchTracker
//
//  Created by Brendan Lensink on 2016-11-17.
//  Copyright © 2016 blensink. All rights reserved.
//

import ReactiveSwift
import enum Result.NoError

class Game {
  let start: MutableProperty<Start?>
  let result: MutableProperty<GameResult?>
  let myHand: MutableProperty<Hand?>
  let theirHand: MutableProperty<Hand?>
  let notes: MutableProperty<String?>
  var isFull: MutableProperty<Bool>
  var (fullStream, fullObserver) = Signal<Bool, NoError>.pipe()
  
  /**
   *  Make a new game with the provided values
   */
  init() {
    start = MutableProperty(nil)
    result = MutableProperty(nil)
    myHand = MutableProperty(nil)
    theirHand = MutableProperty(nil)
    notes = MutableProperty(nil)
    isFull = MutableProperty(false)
    
    isFull.signal.observe(fullObserver)
      
    fullStream = Signal.combineLatest(
      start.signal,
      result.signal,
      myHand.signal,
      theirHand.signal,
      notes.signal
      ).map { inputs in
        return (inputs.0 != nil && inputs.1 != nil && inputs.2 != nil && inputs.3 != nil &&
          inputs.4 != nil)
      }
  }
  
  /**
   *  Make a new game with the provided values
   *
   *  - Parameters:
   *    - date: The date the game happened
   */
  init(start: Start, result: GameResult, myHand: Hand, theirHand: Hand, notes: String) {
    self.start = MutableProperty(start)
    self.result = MutableProperty(result)
    self.myHand = MutableProperty(myHand)
    self.theirHand = MutableProperty(theirHand)
    self.notes = MutableProperty(notes)
    isFull = MutableProperty(true)
    
    isFull.signal.observe(fullObserver)
    
    fullStream = Signal.combineLatest(
      self.start.signal,
      self.result.signal,
      self.myHand.signal,
      self.theirHand.signal,
      self.notes.signal
      ).map { inputs in
        print("checking:", inputs.0 != nil && inputs.1 != nil && inputs.2 != nil && inputs.3 != nil &&
          inputs.4 != nil)
        return (inputs.0 != nil && inputs.1 != nil && inputs.2 != nil && inputs.3 != nil &&
          inputs.4 != nil)
    }  }
  
  func toString() -> String {
//    var returnString = start!.rawValue
//    returnString = returnString + " " + (result?.rawValue)!
//    returnString = returnString + " " + String(describing: myHand)
//    returnString = returnString + " " + String(describing: theirHand)
//    returnString = returnString + " " + notes!
//    return returnString
    return ""
  }
}

enum Start: String {
  case play = "Play"
  case draw = "Draw"
  
  static let allValues = [play, draw]
}

enum GameResult: String {
  case w = "Win"
  case l = "Loss"
  
  static let allValues = [w, l]
}

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
