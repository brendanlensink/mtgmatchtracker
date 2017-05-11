//
//  DataManager.swift
//  MatchTracker
//
//  Created by Brendan Lensink on 2017-05-07.
//  Copyright © 2017 Brendan Lensink. All rights reserved.
//

import Foundation

class DateManager {
    static let shared = DateManager()
    
    private let formatter = DateFormatter()
    
    // Prevent default init from working
    fileprivate init() {
        formatter.dateFormat = "HH:mm MMM dd yyyy"
    }
    
    func toString(date: Date) -> String {
        return formatter.string(from: date)
    }
    
    func toMS(date: Date) -> String {
        return String(describing: (date.timeIntervalSince1970 * 1000).rounded())
    }
}
