//
//  MatchSummaryCell.swift
//  MatchTracker
//
//  Created by Brendan Lensink on 2017-05-13.
//  Copyright © 2017 Brendan Lensink. All rights reserved.
//

import Eureka

final class MatchSummaryCell: Cell<Match>, CellType {
    
    // MARK: Properties
    
    var match: Match?
    
    // MARK: UI Elements
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var formatLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var myDeckLabel: UILabel!
    @IBOutlet weak var theirDeckLabel: UILabel!
    
    required init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func update() {
        if let match = self.match {
            if let created = match.created {
                dateLabel.text = DateManager.shared.toString(date: created)
            }
            if let format = match.format {
                formatLabel.text = format
            }
            resultLabel.text = match.getResult()
            if let myDeck = match.myDeck {
                myDeckLabel.text = myDeck
            }
            
            if let theirDeck = match.theirDeck {
                theirDeckLabel.text = theirDeck
            }
        }
    }
}

// MARK: Eureka Row Class

final class MatchSummaryRow: Row<MatchSummaryCell>, RowType {
    required init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<MatchSummaryCell>(nibName: "MatchSummaryCell")
    }}
