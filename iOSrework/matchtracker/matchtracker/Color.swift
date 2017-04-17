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
        static let light = UIColor(hex: "FFFFFF").alpha(0.5)
    }
    
    struct Blue {
        static let dark = UIColor(hex: "004A9F")
        static let medium = UIColor(hex: "1675D1")
        static let light = UIColor(hex: "62A3FF")
    }
    
    static let white = UIColor.white
    
    // MARK: Color assignments
    
    static let background = Blue.medium
    
    struct Cell {
        static let background = Blue.light
    }
    
    struct TextView {
        static let background = Blue.medium.alpha(0.8)
        static let border = white.alpha(0.7).cgColor
    }
    
    struct Text {
        static let main = white
        static let secondary = Grey.light
    }
    
    struct Button {
        struct Main {
            static let background = Blue.light
            static let inactive = UIColor.clear
        }
    }
    
    struct Picker {
        static let background = Blue.dark
        static let text = white
    }
}
