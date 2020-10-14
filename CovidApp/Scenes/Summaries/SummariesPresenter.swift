//
//  SummariesPresenter.swift
//  CovidApp
//
//  Created by Giorgi Kratsashvili on 10/15/20.
//

import Foundation

protocol SummariesPresenter {
    func handleViewDidLoad()
    func numberOfItems(in section: Int) -> Int
    func didSelectItem(at indexPath: IndexPath)
}

class SummariesPresenterImplementation: SummariesPresenter {

    weak var view: SummariesView?
    let summariesFetchingUseCase: SummariesFetchingUseCase
    let router: SummariesRouter

    var summaries: [CovidSummaryEntity] = .init() // initially empty

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
        summariesFetchingUseCase.fetchSummaries { [weak self] (result) in
            switch result {
            case .success(let summaries):
                self?.summaries = summaries
                self?.view?.reloadData()
            case .failure(let error):
                self?.view?.show(error: error.localizedDescription)
            }
        }
    }

    func numberOfItems(in section: Int) -> Int {
        summaries.count
    }

    func didSelectItem(at indexPath: IndexPath) {
        let identifier = summaries[indexPath.row].identifier
        let params = DetailsParameters(identifier: identifier)
        router.navigateToDetails(with: params)
    }
}
