//
//  FetchConfirmedApiRequest.swift
//  CovidApp
//
//  Created by Giorgi Kratsashvili on 10/14/20.
//

import Foundation

struct FetchConfirmedApiRequest: ApiServiceRequest {

    let identifier: CountryIdentifier

    var urlRequest: URLRequest {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let now = Date()
        let from = dateFormatter.string(from: Calendar.current.date(byAdding: .weekOfYear, value: -1, to: now)!)
        let to = dateFormatter.string(from: now)

        let url = URL(string: "\(root)total/country/\(identifier)/status/confirmed?from=\(from)&to=\(to)")!

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        return request
    }
}
