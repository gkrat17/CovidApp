//
//  SummariesConfigurator.swift
//  CovidApp
//
//  Created by Giorgi Kratsashvili on 10/15/20.
//

import Foundation

struct SummariesConfigurator {

    func configure(_ viewController: SummariesViewController) {

        // Create Gateways
        let apiService: ApiService = ApiServiceImplemetation.defaultShared
        let apiGateway: ApiCovidStatGateway = ApiCovidStatGatewayImplementation(service: apiService)

        let persistService: PersistenceService = PersistenceServiceImplementation.shared
        let localGateway: LocalPersistenceCovidStatGateway = LocalPersistenceCovidStatGatewayImplementation(service: persistService)

        let fetchingGateway: CovidStatFetchingGateway = CacheCovidStatGatewayImplementation(local: localGateway, api: apiGateway)

        // Create UseCases
        let summariesFetchingUseCase: SummariesFetchingUseCase = SummariesFetchingUseCaseImplementation(gateway: fetchingGateway)

        // Create Router
        let router: SummariesRouter = SummariesRouterImplementation(viewController: viewController)

        // Create Presenter
        let presenter: SummariesPresenter = SummariesPresenterImplementation (
            view: viewController,
            summariesFetchingUseCase: summariesFetchingUseCase,
            router: router
        )

        // Inject Presenter into ViewController
        viewController.presenter = presenter
    }
}
