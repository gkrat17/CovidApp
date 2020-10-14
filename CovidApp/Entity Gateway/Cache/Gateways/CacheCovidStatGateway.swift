//
//  CacheCovidStatGateway.swift
//  CovidApp
//
//  Created by Giorgi Kratsashvili on 10/14/20.
//

import Foundation

protocol CacheCovidStatGateway: CovidStatGateway { }

struct CacheCovidStatGatewayImplementation: CacheCovidStatGateway {

    let local: LocalPersistenceCovidStatGateway
    let api: ApiCovidStatGateway

    /**
     
     */
    func fetchSummaries(_ completion: @escaping FetchSummariesHandler) {
        api.fetchSummaries { (result) in
            switch result {
            case .success(let summaries):
                local.upsertSummaries(summaries, nil)
                completion(.success(summaries))
            case .failure:
                local.fetchSummaries(completion)
            }
        }
    }

    /**
     
     */
    func fetchDetails(for identifier: CountryIdentifier,
                      _ completion: @escaping FetchDetailsHandler) {
        api.fetchDetails(for: identifier) { (result) in
            switch result {
            case .success(let details):
                local.upsertDetails(details, nil)
                completion(.success(details))
            case .failure:
                local.fetchDetails(for: identifier, completion)
            }
        }
    }

    // NOTE: not supported by API
    func fetchNotificationsState(for identifier: CountryIdentifier,
                                 _ completion: @escaping FetchNotificationsStateHandler) {
        local.fetchNotificationsState(for: identifier, completion)
    }

    // NOTE: not supported by API
    func upsertSummaries(_ summaries: [CovidSummaryEntity],
                         _ completion: UpsertSummariesHandler?) {
        local.upsertSummaries(summaries, completion)
    }

    // NOTE: not supported by API
    func upsertDetails(_ details: CovidDetailsEntity,
                       _ completion: UpsertDetailsHandler?) {
        local.upsertDetails(details, completion)
    }

    // NOTE: not supported by API
    func updateNotificationsState(for identifier: CountryIdentifier,
                                  with state: NotificationsState,
                                  _ completion: UpdateNotificationHandler?) {
        local.updateNotificationsState(for: identifier, with: state, completion)
    }
}
