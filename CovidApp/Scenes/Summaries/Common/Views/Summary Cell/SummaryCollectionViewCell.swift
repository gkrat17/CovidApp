//
//  SummaryCollectionViewCell.swift
//  CovidApp
//
//  Created by Giorgi Kratsashvili on 10/15/20.
//

import UIKit

class SummaryCollectionViewCell: UICollectionViewCell {

    @IBOutlet var countryNameLabel: UILabel!
    @IBOutlet var totalConfirmedLabel: UILabel!
    @IBOutlet var totalDeathsLabel: UILabel!
    @IBOutlet var totalRecoveredLabel: UILabel!

    static let identifier = "SummaryCollectionViewCell"

    static func nib() -> UINib {
        UINib(nibName: "SummaryCollectionViewCell", bundle: nil)
    }

    func configure(from model: SummaryViewModel) {
        countryNameLabel.text = model.countryName
        totalConfirmedLabel.text = model.totalConfirmed
        totalDeathsLabel.text = model.totalDeaths
        totalRecoveredLabel.text = model.totalRecovered
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderWidth = 2
        layer.cornerRadius = 16
        layer.borderColor = UIColor.separator.cgColor
    }
}
