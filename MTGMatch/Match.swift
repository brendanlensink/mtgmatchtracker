//
//  Match.swift
//  MTGMatchTracker
//
//  Created by Brendan Lensink on 2016-11-17.
//  Copyright © 2016 blensink. All rights reserved.
//

import RealmSwift
import Foundation

class Match: Object {
  dynamic var matchID: String = ""
  dynamic var eventName: String = ""
  dynamic var timeStamp: String = ""
  dynamic var format: String = ""
  dynamic var rel: String = ""
  dynamic var myDeck: String = ""
  dynamic var theirDeck: String = ""
  let games = List<Game>()
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
