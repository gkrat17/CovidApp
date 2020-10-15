//
//  ConfirmedCollectionViewCell.swift
//  CovidApp
//
//  Created by Giorgi Kratsashvili on 10/15/20.
//

import UIKit

class ConfirmedCollectionViewCell: UICollectionViewCell {

    @IBOutlet var countLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!

    func configure(from model: ConfirmedViewModel) {
        countLabel.text = model.count
        dateLabel.text = model.date
    }

    static let identifier = "ConfirmedCollectionViewCell"

    static func nib() -> UINib {
        UINib(nibName: "ConfirmedCollectionViewCell", bundle: nil)
    }
}
