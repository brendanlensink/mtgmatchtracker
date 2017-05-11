//
//  UserDefaults.swift
//  MatchTracker
//
//  Created by Brendan Lensink on 2017-05-07.
//  Copyright © 2017 Brendan Lensink. All rights reserved.
//

import SwiftyUserDefaults

extension DefaultsKeys {
    static let eventName = DefaultsKey<String?>("eventName")
    static let format = DefaultsKey<Format?>("format")
    static let REL = DefaultsKey<REL?>("REL")
    static let myDeck = DefaultsKey<String?>("myDeck")
}

extension UserDefaults {
    subscript(key: DefaultsKey<Format?>) -> Format? {
        get { return unarchive(key) }
        set { archive(key, newValue) }
    }
    
    subscript(key: DefaultsKey<REL?>) -> REL? {
        get { return unarchive(key) }
        set { archive(key, newValue) }
    }
}
