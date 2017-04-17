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
    
    // MARK: Properties
    
    let date: MutableProperty<String?>
    let eventName: MutableProperty<String?>
    let format: MutableProperty<String?>
    let rel: MutableProperty<String?>
    let games: [Game]
    
    let readySignal: Signal<Bool, NoError>
    
    // MARK: Lifecycle
    
    init() {
        date = MutableProperty(nil)
        eventName = MutableProperty(nil)
        format = MutableProperty(nil)
        rel = MutableProperty(nil)
        
        let matchId = "\(DateManager.sharedInstance.toString(date: Date()))_\(UIDevice.current.identifierForVendor!.uuidString)"
        games = [Game(id: matchId, gameNumber: 1),Game(id: matchId, gameNumber: 1), Game(id: matchId, gameNumber: 1)]
        
        readySignal = Signal.combineLatest(
            date.signal,
            eventName.signal,
            format.signal,
            rel.signal
        ).map { inputs in
            return inputs.0 != nil && inputs.1 != nil && inputs.2 != nil && inputs.3 != nil
        }
    }
}
