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
        gateway.fetchSummaries { (result) in
            switch result {
            case .success(var summaries):
                summaries.sort { (lhs: CovidSummaryEntity, rhs: CovidSummaryEntity) -> Bool in
                    return lhs.countryName < rhs.countryName
                }
                completion(.success(summaries))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
