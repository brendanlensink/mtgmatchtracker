//
//  LogMatchViewModel.swift
//  MTGMatchTracker
//
//  Created by Brendan Lensink on 2016-11-18.
//  Copyright © 2016 blensink. All rights reserved.
//

import ReactiveSwift
import enum Result.NoError

class LogMatchViewModel {
  
  // MARK: - Inputs
  
  let date: MutableProperty<String?>
  let format: MutableProperty<String?>
  let rel: MutableProperty<String?>
  let myDeck: MutableProperty<String?>
  let theirDeck: MutableProperty<String?>
  let gameOne: Game
  let gameTwo: Game
  let gameThree: Game
  
  // MARK: - Outputs
  
  let addButtonStream: Signal<Bool, NoError>
  
  // MARK: - Initializer
  
  init() {
    date = MutableProperty(nil)
    format = MutableProperty(nil)
    rel = MutableProperty(nil)
    myDeck = MutableProperty(nil)
    theirDeck = MutableProperty(nil)
    gameOne = Game()
    gameTwo = Game()
    gameThree = Game()
    
    addButtonStream = Signal.combineLatest(
      date.signal,
      format.signal,
      rel.signal,
      myDeck.signal,
      theirDeck.signal,
      gameOne.isFull.signal,
      gameTwo.isFull.signal
    ).map { inputs in
      return inputs.0 != nil && inputs.1 != nil && inputs.2 != nil && inputs.3 != nil &&
        inputs.4 != nil && inputs.5 && inputs.6
    }
  }
  
  func toString() {
    print(date, format, rel, myDeck, theirDeck, gameOne.toString(), gameTwo.toString())
  }
}
