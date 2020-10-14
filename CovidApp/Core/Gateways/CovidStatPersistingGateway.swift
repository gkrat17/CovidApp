//
//  CovidStatPersistingGateway.swift
//  CovidApp
//
//  Created by Giorgi Kratsashvili on 10/14/20.
//

import Foundation

typealias UpsertSummariesHandler = (Result<Void, Error>) -> Void
typealias UpsertDetailsHandler = (Result<Void, Error>) -> Void
typealias UpdateNotificationHandler = (Result<Void, Error>) -> Void

protocol CovidStatPersistingGateway {

    /**
     
     */
    func upsertSummaries(_ summaries: [CovidSummaryEntity],
                         _ completion: UpsertSummariesHandler?)

    /**
     
     */
    func upsertDetails(_ details: CovidDetailsEntity,
                       _ completion: UpsertDetailsHandler?)

    /**
     
     */
    func updateNotification(for identifier: CountryIdentifier,
                            with notification: NotificationState,
                            _ completion: UpdateNotificationHandler?)
}
