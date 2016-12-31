//
//  MatchesViewModel.swift
//  MTGMatchTracker
//
//  Created by Brendan Lensink on 2016-12-10.
//  Copyright © 2016 blensink. All rights reserved.
//

import UIKit
import CoreData
import MessageUI
import RealmSwift

class MatchesViewModel {
  
  // MARK: - Inputs
  
  // MARK: - Outputs
  
  private var matches: Results<Match>? = nil
  
  // MARK: - Initializer
  
  init() {    
  }
  
  /**
   *  Retrieve all the matches from the realm database and store them in the view model
   */
  func getMatches() {    
    let realm = try! Realm() // Create realm pointing to default file
    
    // Query
    matches = realm.objects(Match.self)
  }
  
  /**
   *  Take the match information and return it as a string
   */
  func exportCSV() -> String {
    
    if matches == nil { return "" }
    
    var returnString = "matchID,timestamp,format,rel,myDeck,theirDeck," +
      "gameOne_start,gameOne_result,gameOne_myHand,gameOne_theirHand,gameOne_notes," +
      "gameTwo_start,gameTwo_result,gameTwo_myHand,gameTwo_theirHand,gameTwo_notes," +
      "gameThree_start,gameThree_result,gameThree_myHand,gameThree_theirHand,gameThree_notes\n"
    
    for match in matches! {
      returnString += getFieldOrNil(match.matchID, match.timeStamp, match.format,
        match.rel, match.myDeck, match.theirDeck)
      
      for game in match.games {
        returnString += "\(game.start),\(game.result),\(game.myHand),\(game.theirHand),\(game.notes),"
      }
      
      returnString += "\n"
    }
    
    return returnString
  }
  
  /**
   *  Return the field provided or a string representation of nil
   *
   *  - Parameters: 
   *    - field: The field to check and return
   *
   *  - Returns: The string of the field
   */
  func getFieldOrNil(_ field: String?...) -> String {
    var returnString = ""
    for item in field {
      returnString +=  (item != nil ? item! : "nil") + ","
    }
    
    return returnString
  }
  
  /**
   *  Email the CSV to someone
   */
  func emailCSV(_ text: String) -> MFMailComposeViewController {
    print("email called")
    // MARK: Convert the string to data
    let data = text.data(using: String.Encoding.utf8, allowLossyConversion: false)
    
//    // Unwrapping the optional.
//    if let content = data {
//      print("NSData: \(content)")
//    }
    
    // Generating the email controller.
    func configuredMailComposeViewController() -> MFMailComposeViewController {
      let emailController = MFMailComposeViewController()
      emailController.setSubject("MTGMatchTracker CSV File")
      emailController.setMessageBody("", isHTML: false)
      
      // Attaching the .CSV file to the email.
      emailController.addAttachmentData(data!, mimeType: "text/csv", fileName: "Matches.csv")
      
      return emailController
    }
    
    let emailViewController = configuredMailComposeViewController()
    return emailViewController
  }
  
  // MARK: UITableView Delegate and DataSource Methods
  
  /**
   *  Get the number of sections in the table view
   *
   *  - Returns: The number of sections
   */
  func numberOfSections() -> Int {
    return 1
  }
  
  /**
   *  Get the number of matches in the section
   *
   *  - Parameters:
   *    - section: The section containing the matches
   *
   *  - Returns: The number of matches in the section
   */
  func numberOfMatchesInSection(_ section: Int) -> Int {
    return (matches != nil ? matches!.count : 0)
  }
  
  func getMatchAt(index: Int) -> Match {
    return matches![index]
  }
}
