//
//  BasicProfileView.swift
//  iOS-UISample
//
//  Created by nagisa miura on 2021/02/06.
//

import UIKit

final class BasicProfileView: UIView {

    // MARK: - Properties

    private var user: User?

    @IBOutlet weak private var thumbnailImageView: UIImageView! {
        didSet {
            thumbnailImageView.contentMode = .scaleAspectFill
        }
    }
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var ageLabel: UILabel!
    @IBOutlet weak private var profileTextView: UITextView!

    // MARK: - LifeCycle

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNib()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }

    // MARK: - Helpers

    func configure(user: User) {
        self.user = user
        guard let imageName = user.image else { return }
        thumbnailImageView.image = UIImage.named(imageName)
        nameLabel.text = user.name
        ageLabel.text = "\(user.age) 歳"
        profileTextView.text = user.message
    }
}
