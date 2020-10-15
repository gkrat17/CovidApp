//
//  FetchSummariesApiRequest.swift
//  CovidApp
//
//  Created by Giorgi Kratsashvili on 10/14/20.
//

import Foundation

struct FetchSummariesApiRequest: ApiServiceRequest {

    var urlRequest: URLRequest? {
        guard let url = URL(string: "\(root)summary") else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}
