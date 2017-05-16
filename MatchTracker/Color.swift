//
//  Color.swift
//  MatchTracker
//
//  Created by Brendan Lensink on 2017-05-16.
//  Copyright © 2017 Brendan Lensink. All rights reserved.
//

import UIKit

struct Color {
    
    // MARK: Private color declarations
    
    private struct Blue {
        static let eight = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        static let five = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        static let one = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        static let zero = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
    }
    
    private struct Grey {
        static let eight = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        static let five = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        static let one = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
    }
    private static let white = UIColor.white
    private static let black = UIColor.white
    
    // MARK: Color assignments
    
    static let background = Blue.eight
    
    struct Cell {
        static let background = Blue.one
    }
    
    struct TextView {
        static let background = Blue.one
        static let border = Blue.zero.cgColor
    }
    
    struct Text {
        static let main = white
        static let secondary = Blue.zero
    }
}
