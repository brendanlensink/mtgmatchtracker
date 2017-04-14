//
//  GameCell.swift
//  matchtracker
//
//  Created by Brendan Lensink on 2017-04-13.
//  Copyright © 2017 blensink. All rights reserved.
//

import UIKit

class GameCell: UITableViewCell {
    
    @IBOutlet var startButton: UIButton!
    @IBOutlet var startLabel: UILabel!
    @IBOutlet var resultButton: UIButton!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var myHandPicker: UIPickerView!
    @IBOutlet var theirHandPicker: UIPickerView!
    @IBOutlet var notesField: UITextView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
    }
}

