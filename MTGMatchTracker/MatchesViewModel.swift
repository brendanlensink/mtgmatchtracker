//
//  MatchesViewModel.swift
//  MTGMatchTracker
//
//  Created by Brendan Lensink on 2016-12-10.
//  Copyright © 2016 blensink. All rights reserved.
//

import UIKit
import CoreData

class MatchesViewModel {
  
  // MARK: - Inputs
  
  // MARK: - Outputs
  
  // MARK: - Initializer
  
  init() {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // Create Fetch Request
    let gameFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GameObject")
    let matchFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MatchObject")
    
    // Add Sort Descriptor
    let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
    matchFetchRequest.sortDescriptors = [sortDescriptor]
    
    // Execute Fetch Request
    do {
      print("trying to load")
      let result = try context.fetch(matchFetchRequest)
      let gameResult = try context.fetch(gameFetchRequest)
      
      for managedObject in result {
        print("result found")
        if let date = (managedObject as AnyObject).value(forKey: "date") {
          print(managedObject)
        }
      }
      
    } catch {
      let fetchError = error as NSError
      print(fetchError)
    }
  }
}
