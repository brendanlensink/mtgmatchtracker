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
    
    private var matchId: String? = nil
    private var date: String? = nil
    private var eventName: String? = nil
    private var format: Format? = nil
    private var rel: REL? = nil
    private var myDeck: String? = nil
    private var theirDeck: String? = nil
    private var games: [Game?] = [nil, nil, nil]
    
    // MARK: Reactive Properties
    
    let (dateStream, dateObserver) = Signal<String?, NoError>.pipe()
    let (eventStream, eventObserver) = Signal<String?, NoError>.pipe()
    let (formatStream, formatObserver) = Signal<Format?, NoError>.pipe()
    let (relStream, relObserver) = Signal<REL?, NoError>.pipe()
    let (myDeckStream, myDeckObserver) = Signal<String?, NoError>.pipe()
    let (theirDeckStream, theirDeckObserver) = Signal<String?, NoError>.pipe()
    let (gamesStream, gamesObserver) = Signal<(Int, Game), NoError>.pipe()

    let readySignal: Signal<Bool, NoError>
    
    // MARK: Lifecycle
    
    init() {
        readySignal = Signal.combineLatest(
            dateStream,
            eventStream,
            formatStream,
            relStream
            ).map { inputs in
                return inputs.0 != nil && inputs.1 != nil && inputs.2 != nil && inputs.3 != nil
        }
        
        dateStream.observeValues { value in self.date = value }
        eventStream.observeValues { value in self.eventName = value }
        formatStream.observeValues { value in self.format = value }
        relStream.observeValues { value in self.rel = value }
        myDeckStream.observeValues { value in self.myDeck = value }
        theirDeckStream.observeValues { value in self.theirDeck = value }
        gamesStream.observeValues { (id, game) in
            games[id] = game
        }
        
        matchId = "\(String(describing: Date()))_\(UIDevice.current.identifierForVendor!.uuidString)"
        
        
        let realm = try! Realm()
        let matches = realm.objects(StorableMatch.self)
    
        for match in matches {
            print( "\n\n \(match)")
        }
//        try! realm.write {
//            print("writing")
//            realm.deleteAll()
//        }
    }
    
    func saveMatch() {
        if let matchId = self.matchId {
            let newMatch = StorableMatch()
            newMatch.matchID = matchId
            newMatch.created = self.date
            newMatch.name = self.eventName
            newMatch.format = self.format?.title
            newMatch.REL = self.rel?.title
            newMatch.myDeck = self.myDeck
            newMatch.theirDeck = self.theirDeck
            for game in self.games {
                let newGame = StorableGame()
                newGame.value = game.toHex()
                newMatch.games.append(newGame)
            }
            
            let realm = try! Realm()
            try! realm.write {
                print("writing")
                realm.add(newMatch)
            }
            
            // Save the defaults
            Defaults[.eventName] = self.eventName
            Defaults[.format] = self.format
            Defaults[.REL] = self.rel
            Defaults[.myDeck] = self.myDeck
        }
    }
}
