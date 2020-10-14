//
//  ApiCovidStatGateway.swift
//  CovidApp
//
//  Created by Giorgi Kratsashvili on 10/14/20.
//

import Foundation

protocol ApiCovidStatGateway: CovidStatFetchingGateway { }

struct ApiCovidStatGatewayImplementation: ApiCovidStatGateway {

    let service: ApiService

    func fetchSummaries(_ completion: FetchSummariesHandler) {
        let _ = FetchSummariesApiRequest()
    }

    func fetchDetails(for identifier: CountryIdentifier,
                      _ completion: FetchDetailsHandler) {
        let _ = FetchConfirmedApiRequest(identifier: identifier)
    }

    // fetchNotificationsState and
    // CovidStatPersistingGateway protocol functions
    // are not supported by API
    func fetchNotificationsState(for identifier: CountryIdentifier,
                                 _ completion: FetchNotificationsStateHandler) {
        completion(.failure(CoreError(message: "No support for fetching notification state")))
    }
}
