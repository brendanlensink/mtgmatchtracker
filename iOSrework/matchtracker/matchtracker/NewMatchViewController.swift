//
//  NewMatchViewController.swift
//  matchtracker
//
//  Created by Brendan Lensink on 2017-04-12.
//  Copyright © 2017 blensink. All rights reserved.
//

import UIKit

class NewMatchViewController: UIViewController {
    
    // MARK: UI Elements
    
    private var dateLabel: UILabel
    private var dateButton: UIButton
    private var nameLabel: UILabel
    private var nameField: UITextField
//    private let formatLabel: UILabel
//    private let formatButton: UIButton
//    private let relLabel: UILabel
//    private let relButton: UIButton
//    private let myDeckLabel: UILabel
//    private let myDeckField: UITextField
//    private let theirDeckLabel: UILabel
//    private let theirDeckField: UITextField
    
    // MARK: View Lifecycle
    
    init() {
        dateLabel = UILabel()
        dateButton = UIButton()
        nameLabel = UILabel()
        nameField = UITextField()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        


        view.backgroundColor = Color.background
        
        // MARK: Create the match specific info
    }

}
