//
//  NotificationUpdaterUseCase.swift
//  CovidApp
//
//  Created by Giorgi Kratsashvili on 10/14/20.
//

import Foundation

typealias NotificationUpdaterHandler = (Result<Void, Error>) -> Void

protocol NotificationUpdaterUseCase {
    func updateNotificationsState(with state: NotificationsState,
                                  _ completion: NotificationUpdaterHandler?)
}

struct NotificationUpdaterUseCaseImplementation: NotificationUpdaterUseCase {

    let identifier: CountryIdentifier
    let gateway: CovidStatPersistingGateway

    func updateNotificationsState(with state: NotificationsState,
                                  _ completion: NotificationUpdaterHandler?) {
        gateway.updateNotificationsState(for: identifier, with: state, completion)
    }
}
