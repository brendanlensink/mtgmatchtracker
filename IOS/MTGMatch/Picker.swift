//
//  Picker.swift
//  MTGMatchTracker
//
//  Created by Brendan Lensink on 2016-11-18.
//  Copyright © 2016 blensink. All rights reserved.
//

import UIKit
import ReactiveSwift

class Picker {
  static let sharedInstance = Picker()
  
  // Prevent others from using the default '()' initializer accidently
  private init() {}
  
  /**
   *  Make a format picker view
   *
   *  - Returns: A format picker
   */
  func makeFormatAlert(model: LogMatchViewModel) -> UIAlertController  {
    let alertController = UIAlertController(title: Text.format, message: "", preferredStyle: .alert)

    for format in Format.allValues {
      let action = UIAlertAction(title: format.rawValue, style: .default) { (action) in
        model.format.swap(format.rawValue)
      }
      alertController.addAction(action)
    }
    
    return alertController
  }
  
  /**
   *  Make a REL picker view
   *
   *  - Returns: A REL picker
   */
  func makeRELAlert(model: LogMatchViewModel) -> UIAlertController  {
    let alertController = UIAlertController(title: Text.rel, message: "", preferredStyle: .alert)
    
    for rel in REL.allValues {
      let action = UIAlertAction(title: rel.rawValue, style: .default) { (action) in
        model.rel.swap(rel.rawValue)
      }
      alertController.addAction(action)
    }
    
    return alertController
  }
  
  /**
   *  Make a hand picker view
   *
   *  - Returns: A hand picker
   */
  func makeHandAlert(hand: MutableProperty<Hand>, isTheirs: Bool, model: LogMatchViewModel) -> UIAlertController  {
    var titleText =  Text.myHand
    if(isTheirs) { titleText = Text.theirHand }
    
    let alertController = UIAlertController(title: titleText, message: "", preferredStyle: .alert)
    
    for size in Hand.allValues {
      let action = UIAlertAction(title: String(size.rawValue), style: .default) { (action) in
        if(!isTheirs) {
          hand.swap(size)
        } else {
          hand.swap(size)
        }
      }
      alertController.addAction(action)
    }
    
    return alertController
  }
  

}
