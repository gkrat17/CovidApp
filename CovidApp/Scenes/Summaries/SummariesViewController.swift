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

    @IBOutlet weak var collectionView: UICollectionView!

    private lazy var alertController: UIAlertController = {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        return alertController
    }()

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

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.reloadData()
    }
}

extension SummariesViewController: SummariesView {

    func reloadData() {
        collectionView.reloadData()
    }

    func show(error: String) {
        alertController.title = error
        present(alertController, animated: true, completion: nil)
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

extension SummariesViewController: UICollectionViewDelegateFlowLayout {

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
        let height: CGFloat = 80

        let device = UIDevice.current
        let orientation = device.orientation
        let idiom = device.userInterfaceIdiom

        if (orientation == .landscapeLeft || orientation == .landscapeRight) && idiom == .pad {
            width /= 2
        }
        width -= 2 * collectionViewInset

        return .init(width: width, height: height)
    }
}
