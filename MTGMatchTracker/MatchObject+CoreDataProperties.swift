//
//  MatchObject+CoreDataProperties.swift
//  MTGMatchTracker
//
//  Created by Brendan Lensink on 2016-12-10.
//  Copyright © 2016 blensink. All rights reserved.
//

import Foundation
import CoreData


extension MatchObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MatchObject> {
        return NSFetchRequest<MatchObject>(entityName: "MatchObject");
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var format: String?
    @NSManaged public var rel: String?
    @NSManaged public var myDeck: String?
    @NSManaged public var theirDeck: String?
    @NSManaged public var games: NSOrderedSet?

}

// MARK: Generated accessors for games
extension MatchObject {

    @objc(insertObject:inGamesAtIndex:)
    @NSManaged public func insertIntoGames(_ value: GameObject, at idx: Int)

    @objc(removeObjectFromGamesAtIndex:)
    @NSManaged public func removeFromGames(at idx: Int)

    @objc(insertGames:atIndexes:)
    @NSManaged public func insertIntoGames(_ values: [GameObject], at indexes: NSIndexSet)

    @objc(removeGamesAtIndexes:)
    @NSManaged public func removeFromGames(at indexes: NSIndexSet)

    @objc(replaceObjectInGamesAtIndex:withObject:)
    @NSManaged public func replaceGames(at idx: Int, with value: GameObject)

    @objc(replaceGamesAtIndexes:withGames:)
    @NSManaged public func replaceGames(at indexes: NSIndexSet, with values: [GameObject])

    @objc(addGamesObject:)
    @NSManaged public func addToGames(_ value: GameObject)

    @objc(removeGamesObject:)
    @NSManaged public func removeFromGames(_ value: GameObject)

    @objc(addGames:)
    @NSManaged public func addToGames(_ values: NSOrderedSet)

    @objc(removeGames:)
    @NSManaged public func removeFromGames(_ values: NSOrderedSet)

}
