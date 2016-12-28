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
  fileprivate let dateLabel: UILabel
  fileprivate let formatLabel: UILabel
  fileprivate let resultLabel: UILabel
  
  // MARK: - Lifecycle
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    titleLabel = UILabel()
    dateLabel = UILabel()
    formatLabel = UILabel()
    resultLabel = UILabel()
    
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
    
    titleLabel.text = "Title"
    contentView.addSubview(titleLabel)
    
      // Snapkit
      titleLabel.snp.makeConstraints { make in
        make.top.equalTo(backgroundView)
        make.left.equalTo(backgroundView).offset(GC.Margin.left)
        make.right.equalTo(backgroundView).offset(GC.Margin.right)
      }
    
    // MARK: Make the match date
    
    dateLabel.text = "Date"
    contentView.addSubview(dateLabel)
    
      dateLabel.snp.makeConstraints { make in
        make.top.equalTo(titleLabel.snp.bottom).offset(GC.Padding.vertical)
        make.left.right.equalTo(titleLabel)
      }
      
    // MARK: Make the formay and result labels
    
    formatLabel.text = "Format"
    contentView.addSubview(formatLabel)
    
      // Snapkit
      formatLabel.snp.makeConstraints { make in
        make.top.equalTo(dateLabel.snp.bottom).offset(GC.Padding.vertical)
        make.bottom.equalTo(backgroundView)
        make.left.equalTo(titleLabel)
        make.right.equalTo(contentView.snp.centerX)
      }
    
    resultLabel.text = "Result"
    contentView.addSubview(resultLabel)
    
      // Snapkit
      resultLabel.snp.makeConstraints { make in
        make.centerY.equalTo(formatLabel)
        make.left.equalTo(formatLabel.snp.right)
        make.right.equalTo(backgroundView).offset(GC.Margin.right)
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
    titleLabel.text = match.eventName
    
    let date = Date(timeIntervalSince1970: Double(match.timeStamp)!/1000)
    let dayTimePeriodFormatter = DateFormatter()
    dayTimePeriodFormatter.dateFormat = "MMM dd YYYY hh:mm a"
    let dateString = dayTimePeriodFormatter.string(from: date)
    
    dateLabel.text = dateString
    formatLabel.text = match.format
    
    var wins = 0
    var losses = 0
    
    for game in match.games {
      if(game.result == 1) {
        wins += 1
      }else {
        losses += 1
      }
    }
    
    resultLabel.text = "\(wins) - \(losses)"
    
    
    
  }

}
