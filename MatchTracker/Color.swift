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
        static let eight = #colorLiteral(red: 0, green: 0.2901960784, blue: 0.6235294118, alpha: 1)
        static let five = #colorLiteral(red: 0.0862745098, green: 0.4588235294, blue: 0.8196078431, alpha: 1)
        static let one = #colorLiteral(red: 0.3843137255, green: 0.6392156863, blue: 1, alpha: 1)
        static let zero = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
    }
    
    private struct Grey {
        static let eight = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        static let five = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        static let one = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
    }
    
    private static let white = UIColor.white
    private static let black = UIColor.white
    
    // MARK: Color assignments
    
    static let background = Grey.one
    
    struct TabBar {
        static let tint = Grey.one
    }
    
    struct Cell {
        static let background = Blue.one
        static let title = Grey.eight
        static let placeholder = Grey.five
        static let value = black
    }
    
    struct TextView {
        static let background = Blue.one
        static let border = Grey.one.cgColor
    }
    
    struct Text {
        static let main = Grey.eight
        static let secondary = Blue.eight
    }
}
