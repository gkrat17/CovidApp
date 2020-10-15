//
//  CoreError.swift
//  CovidApp
//
//  Created by Giorgi Kratsashvili on 10/13/20.
//

import Foundation

struct CoreError: LocalizedError {
    var errorDescription: String? { message }
    var message = ""
}
