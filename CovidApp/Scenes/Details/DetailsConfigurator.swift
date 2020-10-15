//
//  DetailsConfigurator.swift
//  CovidApp
//
//  Created by Giorgi Kratsashvili on 10/15/20.
//

import Foundation

struct DetailsConfigurator {

    func configure(_ viewController: DetailsViewController,
                   with params: DetailsParameters) {

        // Create Gateways
        let apiService: ApiService = ApiServiceImplemetation.defaultShared
        let apiGateway: ApiCovidStatGateway = ApiCovidStatGatewayImplementation(service: apiService)

        let persistService: PersistenceService = PersistenceServiceImplementation.shared
        let localGateway: LocalPersistenceCovidStatGateway = LocalPersistenceCovidStatGatewayImplementation(service: persistService)

        let gateway: CovidStatGateway = CacheCovidStatGatewayImplementation(local: localGateway, api: apiGateway)

        // Create UseCases
        let detailsFetchingUseCase: DetailsFetchingUseCase = DetailsFetchingUseCaseImplementation (
            identifier: params.identifier,
            gateway: gateway
        )
        let notificationsStateUseCase: NotificationsStateUseCase = NotificationsStateUseCaseImplementation (
            identifier: params.identifier,
            gateway: gateway
        )

        // Create Presenter
        let presenter: DetailsPresenter = DetailsPresenterImplementation (
            view: viewController,
            identifier: params.identifier,
            detailsFetchingUseCase: detailsFetchingUseCase,
            notificationsStateUseCase: notificationsStateUseCase
        )

        // Inject Presenter into ViewController
        viewController.presenter = presenter
    }
}
