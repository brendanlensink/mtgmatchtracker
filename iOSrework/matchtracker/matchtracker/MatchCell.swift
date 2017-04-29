//
//  MatchCell.swift
//  matchtracker
//
//  Created by Brendan Lensink on 2017-04-28.
//  Copyright © 2017 blensink. All rights reserved.
//

import UIKit

class MatchCell: UITableViewCell {
    @IBOutlet var timeLabel: MatchLabel!
    @IBOutlet var resultLabel: MatchLabel!
    @IBOutlet var formatLabel: MatchLabel!
    @IBOutlet var theirDeckLabel: MatchLabel!
    @IBOutlet var myDeckLabel: MatchLabel!
    
    override func layoutSubviews() {
        self.backgroundColor = UIColor.clear
        
        self.accessoryType = .disclosureIndicator
        
        let dividerView = UIView()
        dividerView.backgroundColor = Color.Cell.border
        self.addSubview(dividerView)
        
        dividerView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.bottom.equalTo(self)
            make.left.right.equalTo(self)
        }
    }
}

class MatchLabel: UILabel {
    override func layoutSubviews() {
        self.textColor = Color.Text.main
    }
}
