//
//  StorableMatch.swift
//  matchtracker
//
//  Created by Brendan Lensink on 2017-04-19.
//  Copyright © 2017 blensink. All rights reserved.
//

import RealmSwift

class StorableMatch: Object {
    dynamic var matchID: String?
    dynamic var created: String?
    dynamic var name: String?
    dynamic var format: String?
    dynamic var REL: String?
    dynamic var myDeck: String?
    dynamic var theirDeck: String?
    let games = List<StorableGame>()
}

class StorableGame: Object {
    var value: String?
}
