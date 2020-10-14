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

    func fetchSummaries(_ completion: @escaping FetchSummariesHandler) {
        let request = FetchSummariesApiRequest()
        service.startRequest(request: request) { (result: Result<ApiServiceResponse<FetchSummariesApiResponse>, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.entity.countries.map { $0.toCovidSummaryEntity() }))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchDetails(for identifier: CountryIdentifier,
                      _ completion: @escaping FetchDetailsHandler) {
        let request = FetchConfirmedApiRequest(identifier: identifier)
        service.startRequest(request: request) { (result: Result<ApiServiceResponse<[FetchConfirmedApiResponse]>, Error>) in
            switch result {
            case .success(let response):
                let confirmed = response.entity.map { $0.toConfirmedEntity() }
                let details = CovidDetailsEntity (
                    identifier: identifier,
                    hasNotifications: false, // NOTE: API has not support for NotificationState
                    confirmed: confirmed
                )
                completion(.success(details))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // fetchNotificationsState and
    // CovidStatPersistingGateway protocol functions
    // are not supported by API
    func fetchNotificationsState(for identifier: CountryIdentifier,
                                 _ completion: FetchNotificationsStateHandler) {
        completion(.failure(CoreError(message: "No support for fetching notification state")))
    }
}
