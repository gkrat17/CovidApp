//
//  NotificationsStateUpdaterUseCase.swift
//  CovidApp
//
//  Created by Giorgi Kratsashvili on 10/14/20.
//

import Foundation

typealias NotificationsStateUpdaterHandler = (Result<Void, Error>) -> Void

protocol NotificationsStateUpdaterUseCase {
    func updateNotificationsState(with state: NotificationsState,
                                  _ completion: NotificationsStateUpdaterHandler?)
}

struct NotificationsStateUpdaterUseCaseImplementation: NotificationsStateUpdaterUseCase {

    let identifier: CountryIdentifier
    let gateway: CovidStatPersistingGateway

    func updateNotificationsState(with state: NotificationsState,
                                  _ completion: NotificationsStateUpdaterHandler?) {
        gateway.updateNotificationsState(for: identifier, with: state, completion)
    }
}
