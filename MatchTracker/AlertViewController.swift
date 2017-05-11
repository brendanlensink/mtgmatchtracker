//
//  AlertViewController.swift
//  MatchTracker
//
//  Created by Brendan Lensink on 2017-05-07.
//  Copyright © 2017 Brendan Lensink. All rights reserved.
//

import UIKit

class AlertController {
    
    static func showAlert(title: String, message: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        return alertController
    }
}
