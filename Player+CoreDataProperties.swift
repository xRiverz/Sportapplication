//
//  Player+CoreDataProperties.swift
//  Sportapplication
//
//  Created by administrator on 11/01/2022.
//
//

import Foundation
import CoreData


extension Player {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Player> {
        return NSFetchRequest<Player>(entityName: "Player")
    }

    @NSManaged public var age: String?
    @NSManaged public var height: String?
    @NSManaged public var name: String?
    @NSManaged public var sport: NSSet?

}

// MARK: Generated accessors for sport
extension Player {

    @objc(addSportObject:)
    @NSManaged public func addToSport(_ value: Sport)

    @objc(removeSportObject:)
    @NSManaged public func removeFromSport(_ value: Sport)

    @objc(addSport:)
    @NSManaged public func addToSport(_ values: NSSet)

    @objc(removeSport:)
    @NSManaged public func removeFromSport(_ values: NSSet)

}

extension Player : Identifiable {

}
