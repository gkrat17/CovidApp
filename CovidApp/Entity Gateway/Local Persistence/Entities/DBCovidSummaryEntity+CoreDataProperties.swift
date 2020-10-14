//
//  DBCovidSummaryEntity+CoreDataProperties.swift
//  CovidApp
//
//  Created by Giorgi Kratsashvili on 10/14/20.
//
//

import Foundation
import CoreData


extension DBCovidSummaryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBCovidSummaryEntity> {
        return NSFetchRequest<DBCovidSummaryEntity>(entityName: "DBCovidSummaryEntity")
    }

    @NSManaged public var countryName: String
    @NSManaged public var identifier: String
    @NSManaged public var totalConfirmed: Int32
    @NSManaged public var totalDeaths: Int32
    @NSManaged public var totalRecovered: Int32
    @NSManaged public var details: DBCovidDetailsEntity?

}

extension DBCovidSummaryEntity : Identifiable {

}

// MARK: - Extension of DBCovidSummaryEntity to create CovidSummaryEntity

extension DBCovidSummaryEntity {

    func toCovidSummaryEntity() -> CovidSummaryEntity {
        return CovidSummaryEntity (
            identifier: identifier as CountryIdentifier,
            countryName: countryName,
            totalConfirmed: Int(totalConfirmed),
            totalDeaths: Int(totalDeaths),
            totalRecovered: Int(totalRecovered)
        )
    }
}
