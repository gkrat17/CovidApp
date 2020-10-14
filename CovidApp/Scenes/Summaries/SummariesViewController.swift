//
//  SummariesViewController.swift
//  CovidApp
//
//  Created by Giorgi Kratsashvili on 10/13/20.
//

import UIKit

protocol SummariesView: class {
    func reloadData()
    func show(error: String)
}

class SummariesViewController: UIViewController {

    var presenter: SummariesPresenter!

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    override func viewDidLoad() {
        super.viewDidLoad()

        let configurator = SummariesConfigurator()
        configurator.configure(self)

        view.backgroundColor = .green
        collectionView.backgroundColor = .brown

        // Configure collectionView
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([ // resize to full screen
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        collectionView.register(SummaryCollectionViewCell.nib(), forCellWithReuseIdentifier: SummaryCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self

        presenter.handleViewDidLoad()
    }
}

extension SummariesViewController: SummariesView {

    func reloadData() {
        collectionView.reloadData()
    }

    func show(error: String) {
        let alertController = UIAlertController(title: error, message: nil, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension SummariesViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        presenter.didSelectItem(at: indexPath)
    }
}

extension SummariesViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItems(in: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SummaryCollectionViewCell.identifier, for: indexPath) as! SummaryCollectionViewCell
        let viewModel = presenter.viewModel(at: indexPath)
        cell.configure(from: viewModel)
        return cell
    }
}

// extension SummariesViewController: UICollectionViewDelegateFlowLayout { }
