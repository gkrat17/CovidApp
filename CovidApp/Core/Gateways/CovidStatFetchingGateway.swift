//
//  CovidStatFetchingGateway.swift
//  CovidApp
//
//  Created by Giorgi Kratsashvili on 10/13/20.
//

import Foundation

typealias FetchSummariesHandler = (Result<[CovidSummaryEntity], Error>) -> Void
typealias FetchDetailsHandler = (Result<CovidDetailsEntity?, Error>) -> Void

protocol CovidStatFetchingGateway {

    /**
     
     */
    func fetchSummaries(_ completion: FetchSummariesHandler)

    /**
     
     */
    func fetchDetails(for identifier: CountryIdentifier,
                      _ completion: FetchDetailsHandler)
}
