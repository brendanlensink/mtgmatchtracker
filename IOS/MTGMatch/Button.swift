//
//  Button.swift
//  MTGMatchTracker
//
//  Created by Brendan Lensink on 2016-11-18.
//  Copyright © 2016 blensink. All rights reserved.
//

import UIKit

class Button: UIButton {
  
  func makeUnderline(button: UIButton) {
    let underline = UIView()
    underline.backgroundColor = Color.TextField.drawer
    button.addSubview(underline)
    
    // Snapkit
    underline.snp.makeConstraints { make in
      make.bottom.equalTo(button.snp.bottom)
      make.height.equalTo(1)
      make.left.right.equalTo(button)
    }
  
  }
  
  func makeUnderline(textField: UITextField) {
    let underline = UIView()
    underline.backgroundColor = Color.TextField.drawer
    textField.addSubview(underline)
    
    // Snapkit
    underline.snp.makeConstraints { make in
      make.bottom.equalTo(textField.snp.bottom).offset(-2)
      make.height.equalTo(1)
      make.left.right.equalTo(textField)
    }
    
  }

}
