//
//  DetailsViewController.swift
//  CovidApp
//
//  Created by Giorgi Kratsashvili on 10/15/20.
//

import UIKit

protocol DetailsView: class {
    func reloadData()
    func show(error: String)
    func set(notifications to: Bool)
}

class DetailsViewController: UIViewController {

    var presenter: DetailsPresenter!

    @IBOutlet weak var collectionView: UICollectionView!

    static func getInstance() -> DetailsViewController {
        return DetailsViewController(nibName: "DetailsView", bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure Collection View
        collectionView.register(ConfirmedCollectionViewCell.nib(),
                                forCellWithReuseIdentifier: ConfirmedCollectionViewCell.identifier)

        presenter.handleViewDidLoad()
    }
}

extension DetailsViewController: DetailsView {

    func reloadData() {
        collectionView.reloadData()
    }

    func show(error: String) {
        let alertController = UIAlertController(title: error, message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction) in
          print("OK logic here")
        }))
        present(alertController, animated: true, completion: nil)
    }

    func set(notifications to: Bool) {
        print("Set Notifications to \(to)")
    }
}

extension DetailsViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItems(in: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ConfirmedCollectionViewCell.identifier, for: indexPath) as! ConfirmedCollectionViewCell
        let viewModel = presenter.viewModel(at: indexPath)
        cell.configure(from: viewModel)
        return cell
    }
}

extension DetailsViewController: UICollectionViewDelegateFlowLayout {

    var collectionViewInset: CGFloat { 10 }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset: CGFloat = collectionViewInset
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: UIScreen.main.bounds.width - 2 * collectionViewInset, height: 80)
    }
}
