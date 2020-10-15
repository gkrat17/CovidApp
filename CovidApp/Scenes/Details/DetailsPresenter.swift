//
//  DetailsPresenter.swift
//  CovidApp
//
//  Created by Giorgi Kratsashvili on 10/15/20.
//

import Foundation

protocol DetailsPresenter {
    func handleViewDidLoad()
    func numberOfItems(in section: Int) -> Int
    func viewModel(at indexPath: IndexPath) -> ConfirmedViewModel
}

class DetailsPresenterImplementation: DetailsPresenter {

    weak var view: DetailsView?

    let detailsFetchingUseCase: DetailsFetchingUseCase
    let notificationsStateUseCase: NotificationsStateUseCase

    var details: CovidDetailsEntity

    init (
        view: DetailsView,
        identifier: CountryIdentifier,
        detailsFetchingUseCase: DetailsFetchingUseCase,
        notificationsStateUseCase: NotificationsStateUseCase
    ) {
        self.view = view
        self.detailsFetchingUseCase = detailsFetchingUseCase
        self.notificationsStateUseCase = notificationsStateUseCase
        self.details = .init(identifier: identifier, hasNotifications: false, confirmed: [])
    }

    func handleViewDidLoad() {

        // Fetch Details
        detailsFetchingUseCase.fetchDetails { [weak self] (result) in
            switch result {
            case .success(let details):
                self?.details = details
                self?.view?.reloadData()
            case .failure(let error):
                self?.view?.show(error: error.localizedDescription)
            }
        }

        // Fetch Notifications State
        notificationsStateUseCase.fetchNotificationsState { [weak self] (result) in
            switch result {
            case .success(let notificationsState):
                let state: Bool = notificationsState
                self?.view?.set(notifications: state)
            case .failure(let error):
                self?.view?.show(error: error.localizedDescription)
            }
        }
    }

    func numberOfItems(in section: Int) -> Int {
        details.confirmed.count
    }

    func viewModel(at indexPath: IndexPath) -> ConfirmedViewModel {
        details.confirmed[indexPath.row].toConfirmedViewModel()
    }
}

fileprivate extension ConfirmedEntity {

    func toConfirmedViewModel() -> ConfirmedViewModel {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let dateToString = dateFormatter.string(from: date)
        return ConfirmedViewModel(count: String(count), date: dateToString)
    }
}
