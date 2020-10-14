//
//  DBConfirmedEntity+CoreDataProperties.swift
//  CovidApp
//
//  Created by Giorgi Kratsashvili on 10/14/20.
//
//

import Foundation
import CoreData


extension DBConfirmedEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBConfirmedEntity> {
        return NSFetchRequest<DBConfirmedEntity>(entityName: "DBConfirmedEntity")
    }

    @NSManaged public var count: Int32
    @NSManaged public var date: Date
    @NSManaged public var details: DBCovidDetailsEntity?

}

extension DBConfirmedEntity : Identifiable {

}

// MARK: - Extension of DBConfirmedEntity to create ConfirmedEntity

extension DBConfirmedEntity {

    func toConfirmedEntity() -> ConfirmedEntity {
        return ConfirmedEntity(count: Int(count), date: date)
    }
}
