//
//  SampleTableHeaderCollectionViewCell.swift
//  iOS-UISample
//
//  Created by nagisa miura on 2021/01/29.
//

import UIKit

final class SampleTableHeaderCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties

    @IBOutlet weak private var avatarImageView: UIImageView! {
        didSet {
            avatarImageView.contentMode = .scaleAspectFill
        }
    }

    // MARK: - LifeCycle

    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
    }

    // MARK: - Helpers

    func configure(user: User) {
        guard let imageName = user.image else { return }
        let image = UIImage.named(imageName)
        avatarImageView.image = image
    }
}
