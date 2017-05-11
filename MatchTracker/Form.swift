//
//  Form.swift
//  MatchTracker
//
//  Created by Brendan Lensink on 2017-05-10.
//  Copyright © 2017 Brendan Lensink. All rights reserved.
//

import Eureka

extension Form {
    
    func valuesNonNil() -> [String: Any] {
        var nonNilValues: [String: Any] = [:]
        
        for item in self.values() {
            if let value = item.value {
                nonNilValues[item.key] = value
            }
        }
        
        return nonNilValues
    }
}
