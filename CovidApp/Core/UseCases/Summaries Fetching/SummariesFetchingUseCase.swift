//
//  SummariesFetchingUseCase.swift
//  CovidApp
//
//  Created by Giorgi Kratsashvili on 10/14/20.
//

import Foundation

typealias SummariesFetchingHandler = (Result<[CovidSummaryEntity], Error>) -> Void

protocol SummariesFetchingUseCase {
    func fetchSummaries(_ completion: @escaping SummariesFetchingHandler)
}

struct SummariesFetchingUseCaseImplementation: SummariesFetchingUseCase {

    let gateway: CovidStatFetchingGateway

    func fetchSummaries(_ completion: @escaping SummariesFetchingHandler) {
        gateway.fetchSummaries(completion)
    }
}
