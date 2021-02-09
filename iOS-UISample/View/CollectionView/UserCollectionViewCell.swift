//
//  UserCollectionViewCell.swift
//  iOS-UISample
//
//  Created by nagisa miura on 2021/02/06.
//

import UIKit

final class UserCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties

    private var user: User?

    @IBOutlet weak private var wrapperView: UIView!
    @IBOutlet weak private var nameLabel: UILabel!

    @IBOutlet weak private var thumbnailImageView: UIImageView! {
        didSet {
            thumbnailImageView.contentMode = .scaleAspectFill
        }
    }

    // MARK: - LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Helpers

    func configure(user: User) {
        self.user = user
        nameLabel.text = user.name
        guard let imageName = user.image else { return }
        thumbnailImageView.image = UIImage.named(imageName)
    }
}
