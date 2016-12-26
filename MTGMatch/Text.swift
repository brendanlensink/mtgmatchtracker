//
//  Text.swift
//  MTGMatchTracker
//
//  Created by Brendan Lensink on 2016-11-18.
//  Copyright © 2016 blensink. All rights reserved.
//

/**
 *  Helper struct for all the text
 */
struct Text {
  static let format = "Format"
  static let rel = "REL"
  
  static let myDeck = "My Deck"
  static let theirDeck = "Their Deck"
  
  static let myHand = "My Hand Size"
  static let theirHand = "Their Hand Size"
  
  static let notes = "Notes"
  
  static let save = "Save"
  
  struct GameCell {
    static let play = "Play"
    static let draw = "Draw"
    static let win = "Win"
    static let loss = "Loss"
    
    static let myHand = "My Hand: "
    static let theirHand = "Their Hand: "
  }
  
  struct Matches {
    static let export = "Export All Matches"
  }
}
