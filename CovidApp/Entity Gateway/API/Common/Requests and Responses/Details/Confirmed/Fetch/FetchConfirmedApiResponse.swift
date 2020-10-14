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
        case dateString = "Date"
    }
}

// MARK: - Extension of FetchConfirmedApiResponse to converting it to ConfirmedEntity

extension FetchConfirmedApiResponse {

    func toConfirmedEntity() -> ConfirmedEntity {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let date = dateFormatter.date(from: dateString)!
        return ConfirmedEntity(count: cases, date: date)
    }
}
