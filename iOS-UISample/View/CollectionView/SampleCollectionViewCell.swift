//
//  SampleCollectionViewCell.swift
//  iOS-UISample
//
//  Created by nagisa miura on 2021/02/06.
//

import UIKit

final class SampleCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties

    private var user: User?

    @IBOutlet weak private var wrapperView: UIView!

    @IBOutlet weak private var nameLabel: UILabel!

    // MARK: - LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
        wrapperView.backgroundColor = .red
    }

    // MARK: - Helpers

    func configure(user: User) {
        self.user = user
        nameLabel.text = user.name
    }
}
