//
//  GC.swift
//  MTGMatchTracker
//
//  Created by Brendan Lensink on 2016-11-18.
//  Copyright © 2016 blensink. All rights reserved.
//

import UIKit

/**
 *  Helper struct for global constants
 */
struct GC {
  struct API {
    static let key = "VO^dqt7*Eq!o"
    static let endpoint = "https://api.brendanlensink.com/api.php/"
  }
  
  struct Padding {
    static let vertical = 7
    static let horizontal = 5
  }
  
  struct Margin {
    static let top = 64
    static let left = 15
    static let right = -15
    static let bottom = -49
    
    struct Cell {
      static let top = 5
      static let bottom = -5
      static let left = 5
      static let right = -5
    }
  }
  
  struct Button {
    static let height = 40
    
    struct Font {
      static let primary = UIFont(name: "HelveticaNeue", size: 25)
    }
  }
  
  struct Font {
    static let main = UIFont(name: "HelveticaNeue", size: 14)
  }
}
