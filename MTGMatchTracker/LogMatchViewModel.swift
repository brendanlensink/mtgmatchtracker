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
  let gameOne: MutableProperty<Game?>
  let gameTwo: MutableProperty<Game?>
  let gameThree: MutableProperty<Game?>
  
  // MARK: - Outputs
  
  let addButtonStream: Signal<Bool, NoError>
  
  // MARK: - Initializer
  
  init() {
    date = MutableProperty(nil)
    format = MutableProperty(nil)
    rel = MutableProperty(nil)
    myDeck = MutableProperty(nil)
    theirDeck = MutableProperty(nil)
    gameOne = MutableProperty(nil)
    gameTwo = MutableProperty(nil)
    gameThree = MutableProperty(nil)
    
    addButtonStream = Signal.combineLatest(
      date.signal,
      format.signal,
      rel.signal,
      myDeck.signal,
      theirDeck.signal,
      gameOne.signal,
      gameTwo.signal
    ).map { inputs in
      return inputs.0 != nil && inputs.1 != nil && inputs.2 != nil && inputs.3 != nil &&
        inputs.4 != nil && inputs.5 != nil && inputs.6 != nil
    }
  }
  
  /**
   * Store a match and reload the view controller
   */
  func saveMatch() -> Bool {
    return true
  }
  
  func toString() {
    print(date, format, rel, myDeck, theirDeck, gameOne.value?.toString(), gameTwo.value?.toString())
  }
}
