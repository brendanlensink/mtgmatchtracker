//
//  Drawer.swift
//  MTGMatchTracker
//
//  Created by Brendan Lensink on 2016-11-18.
//  Copyright © 2016 blensink. All rights reserved.
//

import UIKit

/**
 *  Helper struct containing drawable objects
 */
struct Drawer {
  
  /**
   *  Creates the drawer indicating an editable text area
   *
   *  - Parameters:
   *    - color: The desired text drawer color
   *    - width: Width of the drawer
   *    - height: Height of the drawer edges
   *
   *  - Returns: A UIImageView containing the drawer image
   */
  func editableTextDrawer(color: CGColor, width: CGFloat, height: CGFloat) -> UIImageView {
    UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, 0)
    let context = UIGraphicsGetCurrentContext()

    context?.move(to: CGPoint(x: 0, y: height))
    context?.addLine(to: CGPoint(x: width, y: height))
    context?.setStrokeColor(color)
    context?.drawPath(using: CGPathDrawingMode.fillStroke)
    
    let editableTextDrawerImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return UIImageView(image: editableTextDrawerImage)
  }
}
