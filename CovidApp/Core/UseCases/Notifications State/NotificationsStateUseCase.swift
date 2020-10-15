//
//  NotificationsStateUseCase.swift
//  CovidApp
//
//  Created by Giorgi Kratsashvili on 10/14/20.
//

import Foundation

typealias NotificationsStateFetcherHandler = (Result<NotificationsState, Error>) -> Void
typealias NotificationsStateUpdaterHandler = (Result<Void, Error>) -> Void

protocol NotificationsStateUseCase {

    func fetchNotificationsState(_ completion: @escaping NotificationsStateFetcherHandler)

    func updateNotificationsState(with state: NotificationsState,
                                  _ completion: NotificationsStateUpdaterHandler?)
}

struct NotificationsStateUseCaseImplementation: NotificationsStateUseCase {

    let identifier: CountryIdentifier
    let gateway: CovidStatGateway

    func fetchNotificationsState(_ completion: @escaping NotificationsStateFetcherHandler) {
        gateway.fetchNotificationsState(for: identifier, completion)
    }

    func updateNotificationsState(with state: NotificationsState,
                                  _ completion: NotificationsStateUpdaterHandler?) {
        gateway.updateNotificationsState(for: identifier, with: state, completion)
    }
}
