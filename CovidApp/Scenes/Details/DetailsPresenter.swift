//
//  DetailsPresenter.swift
//  CovidApp
//
//  Created by Giorgi Kratsashvili on 10/15/20.
//

import Foundation

protocol DetailsPresenter {
    func handleViewDidLoad()
}

class DetailsPresenterImplementation: DetailsPresenter {

    weak var view: DetailsView?

    let detailsFetchingUseCase: DetailsFetchingUseCase
    let notificationsStateUpdaterUseCase: NotificationsStateUpdaterUseCase

    init (
        view: DetailsView,
        detailsFetchingUseCase: DetailsFetchingUseCase,
        notificationsStateUpdaterUseCase: NotificationsStateUpdaterUseCase
    ) {
        self.view = view
        self.detailsFetchingUseCase = detailsFetchingUseCase
        self.notificationsStateUpdaterUseCase = notificationsStateUpdaterUseCase
    }

    func handleViewDidLoad() {
        print("In Details Presenter")
    }
}
