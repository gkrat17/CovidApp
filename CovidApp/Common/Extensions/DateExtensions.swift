//
//  DateExtensions.swift
//  CovidApp
//
//  Created by Giorgi Kratsashvili on 10/15/20.
//

import Foundation

extension DateFormatter {

    static func ISO8601DateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        return dateFormatter
    }
}

extension Date {

    func toISO8601String() -> String {
        let dateFormatter = DateFormatter.ISO8601DateFormatter()
        let dateAsString = dateFormatter.string(from: self)
        return dateAsString
    }
}
