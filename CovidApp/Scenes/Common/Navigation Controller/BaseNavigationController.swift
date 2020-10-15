//
//  BaseNavigationController.swift
//  CovidApp
//
//  Created by Giorgi Kratsashvili on 10/16/20.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let viewController = SummariesViewController.getInstance()
        let configurator = SummariesConfigurator()
        configurator.configure(viewController)

        setViewControllers([viewController], animated: true)
    }
}
