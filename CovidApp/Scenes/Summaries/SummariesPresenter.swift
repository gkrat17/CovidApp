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
    func viewModel(at indexPath: IndexPath) -> SummaryViewModel
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

    func viewModel(at indexPath: IndexPath) -> SummaryViewModel {
        summaries[indexPath.row].toSummaryViewModel()
    }

    func didSelectItem(at indexPath: IndexPath) {
        let identifier = summaries[indexPath.row].identifier
        let params = DetailsParameters(identifier: identifier)
        router.navigateToDetails(with: params)
    }
}

fileprivate extension CovidSummaryEntity {

    func toSummaryViewModel() -> SummaryViewModel {
        return SummaryViewModel (
            countryName: countryName,
            totalConfirmed: totalConfirmed != nil ? String(totalConfirmed!) : "--",
            totalDeaths: totalDeaths != nil ? String(totalDeaths!) : "--",
            totalRecovered: totalRecovered != nil ? String(totalRecovered!) : "--"
        )
    }
}
