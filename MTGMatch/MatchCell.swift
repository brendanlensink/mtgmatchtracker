//
//  MatchCell.swift
//  MTGMatch
//
//  Created by Brendan Lensink on 2016-12-21.
//  Copyright © 2016 blensink. All rights reserved.
//

import UIKit

class MatchCell: UITableViewCell {
  
  // MARK: - UI Elements
  
  fileprivate let titleLabel: UILabel
  
  // MARK: - Lifecycle
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    titleLabel = UILabel()
    
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    // MARK: Initialize everything
    
    let backgroundView = UIView()
    backgroundView.backgroundColor = Color.MatchCell.background
    contentView.addSubview(backgroundView)
    
      // Snapkit
      backgroundView.snp.makeConstraints { make in
        make.top.equalTo(contentView).offset(GC.Margin.Cell.top)
        make.bottom.equalTo(contentView).offset(GC.Margin.Cell.bottom)
        make.left.right.equalTo(contentView)
      }
    
    // MARK: Make the match title
    
    titleLabel.text = "Placeholder"
    contentView.addSubview(titleLabel)
    
      // Snapkit
      titleLabel.snp.makeConstraints { make in
        make.edges.equalTo(backgroundView)
      }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  /**
   *  Fill in a match cell's info with the match provided
   *
   *  - Parameters:
   *    - match: The match to pull the info from
   */
  func setMatchInfo(match: Match) {
    let date = Date(timeIntervalSince1970: Double(match.timeStamp)!/1000)
    let dayTimePeriodFormatter = DateFormatter()
    dayTimePeriodFormatter.dateFormat = "MMM dd YYYY hh:mm a"
    let dateString = dayTimePeriodFormatter.string(from: date)
    
    titleLabel.text = dateString + " " + match.format
    
    
    
  }

}
