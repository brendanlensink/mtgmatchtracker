//
//  Color.swift
//  matchtracker
//
//  Created by Brendan Lensink on 2017-04-12.
//  Copyright © 2017 blensink. All rights reserved.
//

import Hue
import UIKit

struct Color {
    
    // MARK: Private Color Declarations
    
    struct Grey {
        static let medium = UIColor(hex: "999999")
    }
    
    struct Blue {
        static let medium = UIColor(hex: "0000FF")
    }
    
    // MARK: Color assignments
    
    static let background = Grey.medium
    
    struct Cell {
        static let background = Blue.medium
    }
}
