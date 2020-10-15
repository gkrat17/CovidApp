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

    @IBOutlet var collectionView: UICollectionView!

    static func getInstance() -> SummariesViewController {
        return SummariesViewController(nibName: "SummariesView", bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure Collection View
        collectionView.register(SummaryCollectionViewCell.nib(),
                                forCellWithReuseIdentifier: SummaryCollectionViewCell.identifier)

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
