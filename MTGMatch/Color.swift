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
  
  private static let darkGrey = UIColor(hex: "22181C")
  private static let grey = UIColor(hex: "312F2F")
  private static let darkerLightBlue = UIColor(hex: "84DCCF")
  private static let lightBlue = UIColor(hex: "F6E8EA")
  private static let orange = UIColor(hex: "EF626C")
  
  private struct Slate {
    static let light = UIColor(hex: "778899")
    static let dark = UIColor(hex: "2F4F4F")
  }
  
  private struct Green {
    static let eight = UIColor(hex: "00695C")
    static let seven = UIColor(hex: "00796B")
    static let four = UIColor(hex: "26A69A")
    static let one = UIColor(hex: "B2DFDB")
    static let zero = UIColor(hex: "E0F2F1")
    static let almostWhite = UIColor(hex: "EAFCFB")
  }
  
  private struct GreenAccent {
    static let seven = UIColor(hex: "00BFA5")
    static let four = UIColor(hex: "1DE9B6")
    static let two = UIColor(hex: "64FFDA")
    static let one = UIColor(hex: "A7FFEB")
  }
  
  // MARK: Color Assignments
  
  static let background = GreenAccent.seven
  
  struct TabBar {
    static let background = GreenAccent.four
    static let text = Slate.dark
  }
  
  struct TextField {
    static let text = Green.almostWhite
    static let placeholder = Green.one
    static let drawer = GreenAccent.two.alpha(0.3)
  }
  
  struct GameCell {
    static let border = GreenAccent.four.alpha(0.3)
    static let textFieldBackground = GreenAccent.four.alpha(0.08)
  
    struct Switch {
      static let on = Green.zero
      static let off = Green.zero
      static let text = Green.almostWhite
      static let border = Green.seven
      static let selected = GreenAccent.four.alpha(0.5)
    }
  }
  
  struct MatchCell {
    static let background = GreenAccent.seven
    static let divider = GreenAccent.two
    
    struct Text {
      static let primary = Green.almostWhite
      static let secondary = Green.one
    }
  }
  
  struct Button {
    struct Text {
      static let primary = lightBlue
    }
    
    struct Background {
      static let primary = grey
    }
  }
  
}
