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
        static let dark = UIColor(hex: "444444").alpha(0.4)
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
    
    static let background = Blue.dark
    
    struct NavBar {
        static let background = Blue.medium
    }
    
    struct Cell {
        static let background = Blue.medium
        static let border = white.alpha(0.2)
    }
    
    struct TextView {
        static let background = Blue.dark.alpha(0.2)
        static let border = white.alpha(0.3).cgColor
    }
    
    struct Text {
        static let main = white
        static let secondary = white.alpha(0.5)
        static let placeholder = white.alpha(0.5)
        static let tint = white
        static let picker = Blue.dark
    }
    
    struct TextField {
        static let underline = white.alpha(0.2)
    }
    
    struct Button {
        struct Main {
            static let background = Blue.light
            static let inactive = UIColor.clear
        }
    }
    
    struct Picker {
        static let background = white
        static let text = Blue.dark
        static let altText = white
    }
    
    struct TabBar {
        static let background = Blue.dark
        static let text = white
    }
}
