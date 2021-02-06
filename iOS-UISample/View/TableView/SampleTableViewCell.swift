//
//  TableViewCell.swift
//  iOS-UISample
//
//  Created by nagisa miura on 2021/01/20.
//

import UIKit

final class SampleTableViewCell: UITableViewCell {

    // MARK: - Properties

    @IBOutlet weak private var profileImage: UIImageView! {
        didSet {
            profileImage.contentMode = .scaleAspectFill
        }
    }

    @IBOutlet weak private var nameLabel: UILabel! {
        didSet {
            nameLabel.textColor = .lightGray
        }
    }

    @IBOutlet weak private var messageLabel: UILabel! {
        didSet {
            messageLabel.textColor = .lightGray
        }
    }

    @IBOutlet weak private var arrowImage: UIImageView! {
        didSet {
            let image = UIImage.named("down_arrow_24pt")
            arrowImage.image = image.withRenderingMode(.alwaysTemplate)
            arrowImage.tintColor = .lightGray
        }
    }

    static let height: CGFloat = 60

    // MARK: - Helpers

    func configure(user: User) {
        nameLabel.text = user.name
        messageLabel.text = user.message
        guard let imageName = user.image else { return }
        profileImage.image = UIImage.named(imageName)
    }
}
