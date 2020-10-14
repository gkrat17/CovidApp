//
//  DBCovidDetailsEntity+CoreDataProperties.swift
//  CovidApp
//
//  Created by Giorgi Kratsashvili on 10/14/20.
//
//

import Foundation
import CoreData


extension DBCovidDetailsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBCovidDetailsEntity> {
        return NSFetchRequest<DBCovidDetailsEntity>(entityName: "DBCovidDetailsEntity")
    }

    @NSManaged public var notifications: Bool
    @NSManaged public var confirmed: NSSet?
    @NSManaged public var summary: DBCovidSummaryEntity?

}

// MARK: Generated accessors for confirmed
extension DBCovidDetailsEntity {

    @objc(addConfirmedObject:)
    @NSManaged public func addToConfirmed(_ value: DBConfirmedEntity)

    @objc(removeConfirmedObject:)
    @NSManaged public func removeFromConfirmed(_ value: DBConfirmedEntity)

    @objc(addConfirmed:)
    @NSManaged public func addToConfirmed(_ values: NSSet)

    @objc(removeConfirmed:)
    @NSManaged public func removeFromConfirmed(_ values: NSSet)

}

extension DBCovidDetailsEntity : Identifiable {

}

// MARK: - Extension of DBCovidDetailsEntity to create CovidDetailsEntity

extension DBCovidDetailsEntity {

    func toCovidDetailsEntity() -> CovidDetailsEntity? {

        guard
            let identifier = summary?.identifier,
            let confirmed = confirmed?.allObjects as? [DBConfirmedEntity]
        else {
            return nil
        }

        return CovidDetailsEntity (
            identifier: identifier,
            hasNotifications: notifications,
            confirmed: confirmed.map { $0.toConfirmedEntity() }
        )
    }
}
