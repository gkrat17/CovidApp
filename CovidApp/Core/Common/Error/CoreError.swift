//
//  CoreError.swift
//  CovidApp
//
//  Created by Giorgi Kratsashvili on 10/13/20.
//

import Foundation

struct CoreError: Error {
    var localizedDescription: String { message }
    var message = ""
}
