//
//  CovidDetailsEntity.swift
//  CovidApp
//
//  Created by Giorgi Kratsashvili on 10/13/20.
//

import Foundation

typealias NotificationState = Bool

struct CovidDetailsEntity {
    let identifier: CountryIdentifier
    let hasNotifications: NotificationState
    let confirmed: [ConfirmedEntity]
}

struct ConfirmedEntity {
    let count: Int
    let date: Date
}
