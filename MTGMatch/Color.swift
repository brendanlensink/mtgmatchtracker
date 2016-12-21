//
//  Color.swift
//  MTGMatchTracker
//
//  Created by Brendan Lensink on 2016-11-18.
//  Copyright © 2016 blensink. All rights reserved.
//

import Hue
import UIKit

/**
 *  Helper struct containing all colors for the app
 */
struct Color {
  
  // MARK: Private Color Declarations
  
  private static let black = UIColor.black
  private static let white = UIColor.white
  
  private struct Slate {
    static let light = UIColor(hex: "778899")
    static let dark = UIColor(hex: "2F4F4F")
  }
  
  // MARK: Color Assignments
  
  struct TextField {
    static let text = Slate.dark
    static let drawer = Slate.light.alpha(0.2)
  }
  
  struct GameCell {
    static let border = Slate.light.alpha(0.2)
  }
  
  static let background = white
  
}
