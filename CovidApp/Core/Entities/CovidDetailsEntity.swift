//
//  CovidDetailsEntity.swift
//  CovidApp
//
//  Created by Giorgi Kratsashvili on 10/13/20.
//

import Foundation

typealias NotificationsState = Bool

struct CovidDetailsEntity {
    let identifier: CountryIdentifier
    var hasNotifications: NotificationsState
    let confirmed: [ConfirmedEntity]
}

struct ConfirmedEntity {
    let count: Int
    let date: Date
}
