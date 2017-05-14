//
//  RealmModel.swift
//  MatchTracker
//
//  Created by Brendan Lensink on 2017-05-14.
//  Copyright © 2017 Brendan Lensink. All rights reserved.
//

import RealmSwift

class RealmModel {

    static let shared = RealmModel()
    
    private let realm: Realm
    
    // Prevent default init from working
    fileprivate init() {
        realm = try! Realm()
    }
    
    // MARK: Public Methods
    
    func getMatches() -> [Match] {
        var returnMatches: [Match] = []
        let matches = realm.objects(Match.self)
        
        for match in matches {
            returnMatches.append(match)
        }
        return returnMatches
    }
    
    func saveMatch(_ match: Match) {
        try! realm.write {
            realm.add(match)
        }
    }
}
