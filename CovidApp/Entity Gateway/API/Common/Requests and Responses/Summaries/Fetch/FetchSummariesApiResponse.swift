//
//  FetchSummariesApiResponse.swift
//  CovidApp
//
//  Created by Giorgi Kratsashvili on 10/14/20.
//

import Foundation

struct FetchSummariesApiResponse: Decodable {

    let countries: [SummaryApiEntity]

    enum CodingKeys: String, CodingKey {
        case countries = "Countries"
    }
}

struct SummaryApiEntity: Decodable {

    let country: String
    let slug: String
    let totalConfirmed: Int?
    let totalDeaths: Int?
    let totalRecovered: Int?

    enum CodingKeys: String, CodingKey {
        case country = "Country"
        case slug = "Slug"
        case totalConfirmed = "TotalConfirmed"
        case totalDeaths = "TotalDeaths"
        case totalRecovered = "TotalRecovered"
    }
}

// MARK: - Extension of SummaryApiEntity to converting it to CovidSummaryEntity

extension SummaryApiEntity {

    func toCovidSummaryEntity() -> CovidSummaryEntity {
        return CovidSummaryEntity (
            identifier: slug,
            countryName: country,
            totalConfirmed: totalConfirmed,
            totalDeaths: totalDeaths,
            totalRecovered: totalRecovered
        )
    }
}
