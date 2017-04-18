//
//  NewMatchViewModel.swift
//  matchtracker
//
//  Created by Brendan Lensink on 2017-04-16.
//  Copyright © 2017 blensink. All rights reserved.
//

import ReactiveSwift
import enum Result.NoError

class NewMatchViewModel {
    
    // MARK: Stored Properties
    
    private var matchId: String? = nil
    private var date: String? = nil
    private var eventName: String? = nil
    private var format: Format? = nil
    private var rel: REL? = nil
    var games: [Game] = []
    
    // MARK: Reactive Properties
    
    let (dateStream, dateObserver) = Signal<String?, NoError>.pipe()
    let (eventStream, eventObserver) = Signal<String?, NoError>.pipe()
    let (formatStream, formatObserver) = Signal<Format?, NoError>.pipe()
    let (relStream, relObserver) = Signal<REL?, NoError>.pipe()

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
        
        matchId = "\(DateManager.sharedInstance.toString(date: Date()))_\(UIDevice.current.identifierForVendor!.uuidString)"
        games = [Game(id: matchId!, gameNumber: 1),Game(id: matchId!, gameNumber: 1), Game(id: matchId!, gameNumber: 1)]
        
    }
    
    func saveMatch() {
        if let matchId = self.matchId {
            let newMatch = Match(id: matchId)
            newMatch.created = self.date
            newMatch.name = self.eventName
            newMatch.format = self.format
            newMatch.games = self.games
            print(newMatch.toDebugString())
        }
    }
}
