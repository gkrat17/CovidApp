//
//  FetchConfirmedApiResponse.swift
//  CovidApp
//
//  Created by Giorgi Kratsashvili on 10/14/20.
//

import Foundation

struct FetchConfirmedApiResponse: Decodable {

    let cases: Int
    let dateString: String

    enum CodingKeys: String, CodingKey {
        case cases = "Cases"
        case dateString = "Date" // in ISO8601 format
    }
}

// MARK: - Extension of FetchConfirmedApiResponse to converting it to ConfirmedEntity

extension FetchConfirmedApiResponse {

    func toConfirmedEntity() -> ConfirmedEntity {
        let dateFormatter = DateFormatter.ISO8601DateFormatter()
        let date = dateFormatter.date(from: dateString)!
        return ConfirmedEntity(count: cases, date: date)
    }
}
