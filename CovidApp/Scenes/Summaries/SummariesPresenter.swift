//
//  SummariesPresenter.swift
//  CovidApp
//
//  Created by Giorgi Kratsashvili on 10/15/20.
//

import Foundation

protocol SummariesPresenter {
    func handleViewDidLoad()
}

class SummariesPresenterImplementation: SummariesPresenter {

    weak var view: SummariesView?
    let summariesFetchingUseCase: SummariesFetchingUseCase
    let router: SummariesRouter

    init (
        view: SummariesView,
        summariesFetchingUseCase: SummariesFetchingUseCase,
        router: SummariesRouter
    ) {
        self.view = view
        self.summariesFetchingUseCase = summariesFetchingUseCase
        self.router = router
    }

    func handleViewDidLoad() {
        print("In Summaries Presenter")
    }
}
