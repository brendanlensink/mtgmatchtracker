//
//  NewMatchViewModel.swift
//  matchtracker
//
//  Created by Brendan Lensink on 2017-04-16.
//  Copyright © 2017 blensink. All rights reserved.
//

import RealmSwift
import ReactiveSwift
import SwiftyUserDefaults
import enum Result.NoError

class NewMatchViewModel {
    
    // MARK: Stored Properties
    
    var match: Match
    
    // MARK: Reactive Properties
    
    let (dateStream, dateObserver) = Signal<Date?, NoError>.pipe()
    let (eventStream, eventObserver) = Signal<String?, NoError>.pipe()
    let (formatStream, formatObserver) = Signal<Format?, NoError>.pipe()
    let (relStream, relObserver) = Signal<REL?, NoError>.pipe()
    let (myDeckStream, myDeckObserver) = Signal<String?, NoError>.pipe()
    let (theirDeckStream, theirDeckObserver) = Signal<String?, NoError>.pipe()
    let (gamesStream, gamesObserver) = Signal<(Int, Game), NoError>.pipe()

    let readySignal: Signal<Bool, NoError>
    
    // MARK: Lifecycle
    
    init() {
        match = Match(value: ["matchID": "\(DateManager.shared.toMS(date: Date()))_\(UIDevice.current.identifierForVendor!.uuidString)"])
        
        readySignal = Signal.combineLatest(
            dateStream,
            eventStream,
            formatStream,
            relStream
        ).map { inputs in
            return inputs.0 != nil && inputs.1 != nil && inputs.2 != nil && inputs.3 != nil
        }
        
        dateStream.observeValues { value in self.match.created = value }
        eventStream.observeValues { value in self.match.name = value }
        formatStream.observeValues { value in self.match.format = value }
        relStream.observeValues { value in self.match.rel = value }
        myDeckStream.observeValues { value in self.match.myDeck = value }
        theirDeckStream.observeValues { value in self.match.theirDeck = value }
        gamesStream.observeValues { (id, game) in self.match.games[id] = game }
        
        /******************************
         
         Debugging info
         
         */
        let realm = try! Realm()
        let matches = realm.objects(Match.self)
    
        for match in matches {
            print( "\n\n \(match)")
        }
//        try! realm.write {
//            print("writing")
//            realm.deleteAll()
//        }
        /**********************************
         
                */
    }
    
    func saveMatch() {
        let realm = try! Realm()
        try! realm.write {
        
            match.storeGames()
            realm.add(match)
        }
        
        // Save the defaults
//        Defaults[.eventName] = self.eventName
//        Defaults[.format] = self.format
//        Defaults[.REL] = self.rel
//        Defaults[.myDeck] = self.myDeck
    }
}
