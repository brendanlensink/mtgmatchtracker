//
//  MatchHistoryViewModel.swift
//  matchtracker
//
//  Created by Brendan Lensink on 2017-04-28.
//  Copyright © 2017 blensink. All rights reserved.
//

import RealmSwift

class MatchHistoryViewModel {
    
    // MARK: Properties
    
    var matches: [Match]
    
    // MARK: Lifecycle
    
    init() {
        // TODO: All of the realm nonsense should be in a model, that make a lot more sense
        self.matches = []
        let realm = try! Realm()
        let matches = realm.objects(Match.self)
        for match in matches {
            self.matches.append(match)
        }
    }
    
    // MARK: UITableViewDataSource Methods
    
    func getMatchCount() -> Int {
        return matches.count
    }
    
    func getMatchAt(index: Int) -> Match {
        return matches[index]
    }
}
