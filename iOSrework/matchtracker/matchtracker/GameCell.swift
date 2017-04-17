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
    @IBOutlet var myHandLabel: UILabel!
    @IBOutlet var theirHandPicker: UIPickerView!
    @IBOutlet var theirHandLabel: UILabel!
    @IBOutlet var notesField: UITextView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        startButton.tag = 1
        resultButton.tag = 2

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func resultButtonTouched(_ sender: UIButton) {
        if sender.titleLabel!.text == "Win" {
            sender.setTitle("Loss", for: .normal)
            resultLabel.text = "Win"
        }else {
            sender.setTitle("Win", for: .normal)
            resultLabel.text = "Loss"
        }
    }
    
    @IBAction func startButtonTouched(_ sender: UIButton) {
        if sender.titleLabel!.text == "Play" {
            sender.setTitle("Draw", for: .normal)
            startLabel.text = "Play"
        }else {
            sender.setTitle("Play", for: .normal)
            startLabel.text = "Draw"
        }
    }
    
    override func layoutSubviews() {
        self.contentView.backgroundColor = Color.Cell.background
        
        startButton.setTitleColor(Color.Text.main, for: .normal)
        startLabel.textColor = Color.Text.secondary
        
        resultButton.setTitleColor(Color.Text.main, for: .normal)
        resultLabel.textColor = Color.Text.secondary
        
        myHandLabel.textColor = Color.Text.secondary
        theirHandLabel.textColor = Color.Text.secondary
        
        notesField.backgroundColor = Color.TextView.background
        notesField.layer.borderColor = Color.TextView.border
        notesField.layer.cornerRadius = 4
        notesField.layer.borderWidth = 1
        
        // MARK: Button Responders

        
        
    }
}

