//
//  Match.swift
//  MTGMatchTracker
//
//  Created by Brendan Lensink on 2016-11-17.
//  Copyright © 2016 blensink. All rights reserved.
//

import Foundation

class Match {
  let date: String
  let format: Format
  let rel: REL
  let myDeck: String
  let theirDeck: String
  let games: [Game] = []
  
  /**
   *  Make a new match
   *
   *  - Parameters:
   *    - date: The date of the match
   *    - format: The format played
   *    - rel: The REL the game was played at
   *    - myDeck: The deck the user played
   *    - theirDeck: Best guess for their deck
   */
  init(date: String, format: Format, rel: REL, myDeck: String, theirDeck: String) {
    self.date = date
    self.format = format
    self.rel = rel
    self.myDeck = myDeck
    self.theirDeck = theirDeck
  }
}

enum REL: String {
  case casual = "Casual"
  case competitive = "Competitive"
  case pro = "Pro"
  
  static let allValues = [casual,competitive,pro]
}

enum Format: String {
  case sealed = "Sealed"
  case draft = "Draft"
  case standard = "Standard"
  case modern = "Modern"
  case legacy = "Legacy"
  
  static let allValues = [sealed, draft, standard, modern, legacy]
}
