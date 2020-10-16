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

    private lazy var alertController: UIAlertController = {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel) { _ in
            self.navigationController?.popViewController(animated: true)
        })
        return alertController
    }()

    private lazy var bellOnImage = UIImage(named: "bellOn")?.withRenderingMode(.alwaysOriginal)
    private lazy var bellOffImage = UIImage(named: "bellOff")?.withRenderingMode(.alwaysOriginal)

    static func getInstance() -> DetailsViewController {
        return DetailsViewController(nibName: "DetailsView", bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Details"

        // Configure Navigation Item
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(notificationsTapped))

        // Configure Collection View
        collectionView.register(ConfirmedCollectionViewCell.nib(),
                                forCellWithReuseIdentifier: ConfirmedCollectionViewCell.identifier)

        presenter.handleViewDidLoad()
    }

    @objc func notificationsTapped() {
        presenter.handleNotificationsTapped()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.reloadData()
    }
}

extension DetailsViewController: DetailsView {

    func reloadData() {
        collectionView.reloadData()
    }

    func show(error: String) {
        alertController.title = error
        present(alertController, animated: true, completion: nil)
    }

    func set(notifications to: Bool) {
        switch to {
        case true: navigationItem.rightBarButtonItem?.image = bellOnImage
        case false: navigationItem.rightBarButtonItem?.image = bellOffImage
        }
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

        var width: CGFloat = UIScreen.main.bounds.width
        let height: CGFloat = 100

        if UIDevice.current.userInterfaceIdiom == .pad {
            width /= 2
        }

        width -= 2 * collectionViewInset

        return .init(width: width, height: height)
    }
}
