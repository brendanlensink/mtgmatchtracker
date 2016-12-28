//
//  UserDefaultsModel.swift
//  MTGMatch
//
//  Created by Brendan Lensink on 2016-12-24.
//  Copyright © 2016 blensink. All rights reserved.
//

import UIKit

class UserDefaultsModel {
  static let sharedInstance = UserDefaultsModel()
  
  // Prevent others from accidentally using default init
  fileprivate init() {}
  
  fileprivate let defaults = UserDefaults.standard
  
  // MARK: - Event Name
  
  /**
   *  Set the default event name for the next match
   *
   *  - Parameters:
   *    - eventName: The eventName to set as the default
   */
  func setEventName(_ eventName: String) {
    defaults.set(eventName, forKey: "eventName")
  }
  
  /**
   *  Get the default event name for a match
   *
   *  - Returns: The current default event name
   */
  func getEventName() -> String? {
    return defaults.object(forKey: "eventName") != nil ?
      (defaults.object(forKey: "eventName") as! String) : nil
  }
  
  // MARK: - Format
  
  /**
   *  Set the default format for the next match
   *
   *  - Parameters:
   *    - format: The format to set as the default
   */
  func setFormat(_ format: String) {
    defaults.set(format, forKey: "format")
  }
  
  /**
   *  Get the default format for a match
   *
   *  - Returns: The current default format
   */
  func getFormat() -> String? {
    return defaults.object(forKey: "format") != nil ?
      (defaults.object(forKey: "format") as! String) : nil
  }
  
  // MARK: - REL
  
  /**
   *  Set the default rel for the next match
   *
   *  - Parameters:
   *    - rel: The rel to set as the default
   */
  func setREL(_ rel: String) {
    defaults.set(rel, forKey: "rel")
  }
  
  /**
   *  Get the default rel for a match
   *
   *  - Returns: The current default rel
   */
  func getREL() -> String? {
    return defaults.object(forKey: "rel") != nil ? (defaults.object(forKey: "rel") as! String) : nil
  }
  
  // MARK - My Deck
  
  /**
   *  Set the default myDeck for the next match
   *
   *  - Parameters:
   *    - rel: The myDeck to set as the default
   */
  func setMyDeck(_ myDeck: String) {
    defaults.set(myDeck, forKey: "myDeck")
  }
  
  /**
   *  Get the default myDeck for a match
   *
   *  - Returns: The current default myDeck
   */
  func getMyDeck() -> String? {
    return defaults.object(forKey: "myDeck") != nil ?
      (defaults.object(forKey: "myDeck") as! String) : nil
  }
  

}
