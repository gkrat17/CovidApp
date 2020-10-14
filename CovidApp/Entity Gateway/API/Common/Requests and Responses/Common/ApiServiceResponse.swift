//
//  ApiServiceResponse.swift
//  CovidApp
//
//  Created by Giorgi Kratsashvili on 10/14/20.
//

import Foundation

struct ApiServiceResponse<T: Decodable> {
    let entity: T
}
