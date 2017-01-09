//
//  ApiModel.swift
//  MTGMatch
//
//  Created by Brendan Lensink on 2017-01-06.
//  Copyright © 2017 blensink. All rights reserved.
//

import Alamofire
import ReactiveSwift
import enum Result.NoError

class ApiModel {
  static let sharedInstance = ApiModel()
  
  // Prevent default init from working
  fileprivate init() {}
  
  // MARK: - Send Match Functions
  
  func sendMatch(match: Match) -> Signal<(Int, NSDictionary), NoError> {
    let URL = GC.API.endpoint + "matches/"
    
    let (responseStream, responseObserver) = Signal<(Int, NSDictionary), NoError>.pipe()
 
    // MARK: Make the headers for the request
    
    let headers: HTTPHeaders = [
      "authkey": GC.API.key,
      "id": UIDevice.current.identifierForVendor!.uuidString
    ]
    
    // MARK: Make the post dictionary of all the match info
    
    var postDictionary: [String:Any] = [
      "matchId": match.matchID,
      "eventName": match.eventName,
      "datetime": match.timeStamp,
      "myDeck": match.myDeck,
      "theirDeck": match.theirDeck
    ]
    
    var gameCount = 0
    for game in match.games {
      postDictionary[String(gameCount)] = [
        "game": game.game,
        "start": game.start,
        "result": game.result,
        "myHand": game.myHand,
        "theirHand": game.theirHand,
        "notes": game.notes
      ]
      gameCount += 1
    }
    
    print(URL)
    
    // MARK: Send it all off!
    
    Alamofire.request(URL, method: .post, parameters: postDictionary,
        encoding: JSONEncoding.default, headers: headers).validate().responseJSON { response in
      var responseJSON: NSDictionary = [:]
      print("Request sent")
      switch response.result {
      case .success:
        if let result = response.result.value {
          responseJSON = result as! NSDictionary
          print("response:")
          print(responseJSON)
        }
      case .failure(_):
        let statusCode = response.response?.statusCode
        
        if let result = response.result.value {
          responseJSON = result as! NSDictionary
          print("response:", statusCode)
          print(responseJSON)
        }

      }
          
    }
    
    return responseStream
  }
  
  
  
}
