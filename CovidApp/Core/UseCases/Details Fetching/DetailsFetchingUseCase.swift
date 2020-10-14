//
//  DetailsFetchingUseCase.swift
//  CovidApp
//
//  Created by Giorgi Kratsashvili on 10/14/20.
//

import Foundation

typealias DetailsFetchingHandler = (Result<CovidDetailsEntity, Error>) -> Void

protocol DetailsFetchingUseCase {
    func fetchDetails(_ completion: @escaping DetailsFetchingHandler)
}

struct DetailsFetchingUseCaseImplementation: DetailsFetchingUseCase {

    let identifier: CountryIdentifier
    let gateway: CovidStatFetchingGateway

    func fetchDetails(_ completion: @escaping DetailsFetchingHandler) {
        gateway.fetchDetails(for: identifier, completion)
    }
}
