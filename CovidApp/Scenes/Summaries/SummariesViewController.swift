//
//  SummariesViewController.swift
//  CovidApp
//
//  Created by Giorgi Kratsashvili on 10/13/20.
//

import UIKit

protocol SummariesView: class { }

class SummariesViewController: UIViewController {

    var presenter: SummariesPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        let configurator = SummariesConfigurator()
        configurator.configure(self)
        presenter.handleViewDidLoad()
    }
}

extension SummariesViewController: SummariesView { }
