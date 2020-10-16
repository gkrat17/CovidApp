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
    func handleNotificationsTapped()
}

class DetailsPresenterImplementation: DetailsPresenter {

    weak var view: DetailsView?

    let detailsFetchingUseCase: DetailsFetchingUseCase
    let notificationsStateUpdaterUseCase: NotificationsStateUpdaterUseCase

    var details: CovidDetailsEntity

    init (
        view: DetailsView,
        identifier: CountryIdentifier,
        detailsFetchingUseCase: DetailsFetchingUseCase,
        notificationsStateUpdaterUseCase: NotificationsStateUpdaterUseCase
    ) {
        self.view = view
        self.detailsFetchingUseCase = detailsFetchingUseCase
        self.notificationsStateUpdaterUseCase = notificationsStateUpdaterUseCase
        self.details = .init(identifier: identifier, hasNotifications: false, confirmed: [])
    }

    func handleViewDidLoad() {
        detailsFetchingUseCase.fetchDetails { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let details):
                self.details = details
                self.view?.set(notifications: details.hasNotifications)
                self.view?.reloadData()
            case .failure(let error):
                self.view?.show(error: error.localizedDescription)
            }
        }
    }

    func numberOfItems(in section: Int) -> Int {
        details.confirmed.count
    }

    func viewModel(at indexPath: IndexPath) -> ConfirmedViewModel {
        details.confirmed[indexPath.row].toConfirmedViewModel()
    }

    func handleNotificationsTapped() {
        notificationsStateUpdaterUseCase.updateNotificationsState(with: !details.hasNotifications) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success:
                self.details.hasNotifications.toggle()
                self.view?.set(notifications: self.details.hasNotifications)
            case .failure(let error):
                self.view?.show(error: error.localizedDescription)
            }
        }
    }
}

fileprivate extension ConfirmedEntity {

    func toConfirmedViewModel() -> ConfirmedViewModel {
        return ConfirmedViewModel(count: String(count), date: date.toLocalizedString())
    }
}
