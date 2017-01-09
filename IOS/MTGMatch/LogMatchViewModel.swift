//
//  LogMatchViewModel.swift
//  MTGMatchTracker
//
//  Created by Brendan Lensink on 2016-11-18.
//  Copyright © 2016 blensink. All rights reserved.
//

import RealmSwift
import ReactiveSwift
import enum Result.NoError

class LogMatchViewModel {
  
  // MARK: - Inputs
  
  let eventName: MutableProperty<String?>
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
  let (serverResponseStream, serverResponseObserver) =
    Signal<(Dictionary<String, AnyObject>, Int), NoError>.pipe()
  let (successStream, successObserver) = Signal<Bool, NoError>.pipe()
  let (errorStream, errorObserver) = Signal<String, NoError>.pipe()
  
  // MARK: - Initializer
  
  init() {
    eventName = MutableProperty(nil)
    date = MutableProperty(nil)
    format = MutableProperty(nil)
    rel = MutableProperty(nil)
    myDeck = MutableProperty(nil)
    theirDeck = MutableProperty(nil)
    gameOne = MutableProperty(nil)
    gameTwo = MutableProperty(nil)
    gameThree = MutableProperty(nil)
    
    addButtonStream = Signal.combineLatest(
      eventName.signal,
      date.signal,
      format.signal,
      rel.signal,
      myDeck.signal,
      theirDeck.signal,
      gameOne.signal,
      gameTwo.signal
    ).map { inputs in
      return inputs.0 != nil && inputs.1 != nil && inputs.2 != nil && inputs.3 != nil &&
        inputs.4 != nil && inputs.5 != nil && inputs.6 != nil && inputs.7 != nil
    }
  }
  
  /**
   * Store a match and reload the view controller
   */
  func saveMatch() -> Bool {
    
    // MARK: Step 1: Generate a match id from the device id + timestamp
    
    let deviceID = UIDevice.current.identifierForVendor!.uuidString
    let timestamp = UInt64(NSDate().timeIntervalSince1970 * 1000.0)
    let matchID = deviceID + "_" + String(timestamp)
    
    let newMatch = Match()
    newMatch.matchID = matchID
    newMatch.eventName = eventName.value!
    newMatch.timeStamp = String(timestamp)
    newMatch.format = format.value!
    newMatch.rel = rel.value!
    newMatch.myDeck = myDeck.value!
    newMatch.theirDeck = theirDeck.value!
    
    let firstGame = self.gameOne.value!
    firstGame.matchID = matchID
    newMatch.games.append(firstGame)
    
    let secondGame = self.gameTwo.value!
    secondGame.matchID = matchID
    newMatch.games.append(secondGame)
    
    if (gameThree.value != nil) {
      let thirdGame = self.gameThree.value!
      thirdGame.matchID = matchID
      newMatch.games.append(thirdGame)
    }
    
    // MARK: Step 2: Write the match to realm
    
    let realm = try! Realm() // Create realm pointing to default file
    
    // Save your object
    realm.beginWrite()
    realm.add(newMatch)
    try! realm.commitWrite()
    
    // MARK: Attempt to send the match to the server
    
    _ = ApiModel.sharedInstance.sendMatch(match: newMatch)
    
    // MARK: Step 4: Save the info filled in to user defaults to populate the next match
    
    let defaults = UserDefaultsModel.sharedInstance
    defaults.setEventName(eventName.value!)
    defaults.setFormat(format.value!)
    defaults.setREL(rel.value!)
    defaults.setMyDeck(myDeck.value!)
        
    return true
  }
}
