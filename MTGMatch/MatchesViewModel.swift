//
//  MatchesViewModel.swift
//  MTGMatchTracker
//
//  Created by Brendan Lensink on 2016-12-10.
//  Copyright © 2016 blensink. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class MatchesViewModel {
  
  // MARK: - Inputs
  
  // MARK: - Outputs
  
  // MARK: - Initializer
  
  init() {    
  }
  
  func getMatches() {    
    let realm = try! Realm() // Create realm pointing to default file
    
    // Query
    let results = realm.objects(Match.self)
    
    print(results.count)
    

  }
}
