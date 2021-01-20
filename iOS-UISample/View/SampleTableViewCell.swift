//
//  TableViewCell.swift
//  iOS-UISample
//
//  Created by nagisa miura on 2021/01/20.
//

import UIKit

final class SampleTableViewCell: UITableViewCell {

    // MARK: - Properties

    @IBOutlet weak private var horizontalStackView: UIStackView! {
        didSet {
            horizontalStackView.spacing = 4
        }
    }

    @IBOutlet weak private var verticalStackView: UIStackView! {
        didSet {
            verticalStackView.spacing = 4
        }
    }
    
    @IBOutlet weak private var profileImage: UIImageView! {
        didSet {
            profileImage.contentMode = .scaleAspectFill
            profileImage.clipsToBounds = true
        }
    }

    @IBOutlet weak private var nameLabel: UILabel! {
        didSet {
            nameLabel.font = UIFont.boldSystemFont(ofSize: 14)
            nameLabel.textColor = .lightGray
        }
    }

    @IBOutlet weak private var messageLabel: UILabel! {
        didSet {
            messageLabel.font = UIFont.boldSystemFont(ofSize: 12)
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

    // MARK: - LifeCycle

    override func layoutSubviews() {
        super.layoutSubviews()
        profileImage.layer.cornerRadius = profileImage.frame.size.height / 2
    }

    // MARK: - Helpers

    func configure(user: User) {
        nameLabel.text = user.name
        messageLabel.text = user.message
        guard let imageName = user.image else { return }
        profileImage.image = UIImage.named(imageName)
    }
}
