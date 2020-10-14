//
//  CovidSummaryEntity.swift
//  CovidApp
//
//  Created by Giorgi Kratsashvili on 10/13/20.
//

import Foundation

typealias CountryIdentifier = String

struct CovidSummaryEntity {
    let identifier: CountryIdentifier
    let countryName: String
    let totalConfirmed: Int?
    let totalDeaths: Int?
    let totalRecovered: Int?
}
