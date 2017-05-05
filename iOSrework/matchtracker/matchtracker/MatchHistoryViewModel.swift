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
        refreshMatchHistory()
    }
    
    // MARK: Helper Functions
    
    func exportCSV() -> Data? {
        var returnString = "id,created,name,format,rel,mydeck,theirdeck,game,start,result,myhand,theirhand,notes,game,start,result,myhand,theirhand,notes,game,start,result,myhand,theirhand,notes\n"
        for match in matches {
            returnString += match.toCSV()
        }
        
        return returnString.data(using: .utf8, allowLossyConversion: false)
    }
    
    // MARK: UITableViewDataSource Methods
    
    func refreshMatchHistory() {
        let realm = try! Realm()
        let matches = realm.objects(Match.self)
        for match in matches {
            self.matches.append(match)
        }
    }
    
    func getMatchCount() -> Int {
        return matches.count
    }
    
    func getMatchAt(index: Int) -> Match {
        return matches[index]
    }
}
