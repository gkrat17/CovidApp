//
//  SummariesRouter.swift
//  CovidApp
//
//  Created by Giorgi Kratsashvili on 10/15/20.
//

import UIKit

protocol SummariesRouter {
    func navigateToDetails(with params: DetailsParameters)
}

struct SummariesRouterImplementation: SummariesRouter {

    weak var viewController: SummariesViewController?

    func navigateToDetails(with params: DetailsParameters) {
        let viewController = DetailsViewController.getInstance()
        let configurator = DetailsConfigurator()
        configurator.configure(viewController, with: params)
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
}
