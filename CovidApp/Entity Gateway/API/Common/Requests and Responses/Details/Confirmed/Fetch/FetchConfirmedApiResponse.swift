//
//  FetchConfirmedApiResponse.swift
//  CovidApp
//
//  Created by Giorgi Kratsashvili on 10/14/20.
//

import Foundation

struct FetchConfirmedApiResponse: Decodable {

    let cases: Int
    let date: Date

    enum CodingKeys: String, CodingKey {
        case cases = "Cases"
        case date = "Date"
    }
}

// MARK: - Extension of FetchConfirmedApiResponse to converting it to ConfirmedEntity

extension FetchConfirmedApiResponse {

    func toConfirmedEntity() -> ConfirmedEntity {
        return ConfirmedEntity(count: cases, date: date)
    }
}
