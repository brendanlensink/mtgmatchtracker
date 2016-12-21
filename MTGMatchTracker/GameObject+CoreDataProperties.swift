//
//  GameObject+CoreDataProperties.swift
//  MTGMatchTracker
//
//  Created by Brendan Lensink on 2016-12-10.
//  Copyright © 2016 blensink. All rights reserved.
//

import Foundation
import CoreData


extension GameObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GameObject> {
        return NSFetchRequest<GameObject>(entityName: "GameObject");
    }

    @NSManaged public var start: Bool
    @NSManaged public var result: Bool
    @NSManaged public var myHand: Int16
    @NSManaged public var theirHand: Int16
    @NSManaged public var notes: String?
    @NSManaged public var match: MatchObject?

}
