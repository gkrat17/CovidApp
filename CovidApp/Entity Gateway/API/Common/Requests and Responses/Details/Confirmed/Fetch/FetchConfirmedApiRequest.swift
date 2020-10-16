//
//  FetchConfirmedApiRequest.swift
//  CovidApp
//
//  Created by Giorgi Kratsashvili on 10/14/20.
//

import Foundation

struct FetchConfirmedApiRequest: ApiServiceRequest {

    let identifier: CountryIdentifier

    var urlRequest: URLRequest? {

        let calendar = Calendar.current
        let starting = calendar.date(byAdding: .day, value: -1, to: Date())!
        let from = calendar.date(byAdding: .month, value: -1, to: starting)!.toISO8601String()
        let to = starting.toISO8601String()

        guard let url = URL(string: "\(root)total/country/\(identifier)/status/confirmed?from=\(from)&to=\(to)")
        else { return nil }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        return request
    }
}
