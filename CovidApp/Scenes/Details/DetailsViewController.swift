//
//  DetailsViewController.swift
//  CovidApp
//
//  Created by Giorgi Kratsashvili on 10/15/20.
//

import UIKit

protocol DetailsView: class { }

class DetailsViewController: UIViewController {

    var presenter: DetailsPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.handleViewDidLoad()
        view.backgroundColor = .red
    }
}

extension DetailsViewController: DetailsView { }
