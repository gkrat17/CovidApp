//
//  ApiServiceRequest.swift
//  CovidApp
//
//  Created by Giorgi Kratsashvili on 10/14/20.
//

import Foundation

protocol ApiServiceRequest {
    var root: String { get }
    var urlRequest: URLRequest? { get }
}

extension ApiServiceRequest {
    var root: String { "https://api.covid19api.com/" }
}
