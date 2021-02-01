//
//  SampleTableHeaderCollectionViewCell.swift
//  iOS-UISample
//
//  Created by nagisa miura on 2021/01/29.
//

import UIKit

final class SampleTableHeaderCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties

    @IBOutlet weak private var wrapperView: UIView!
    @IBOutlet weak private var avatarImageView: UIImageView! {
        didSet {
            avatarImageView.contentMode = .scaleAspectFill
            let tapGesture = UITapGestureRecognizer(
                target: self,
                action: #selector(avatarImageViewTapped))
            avatarImageView.isUserInteractionEnabled = true
            avatarImageView.addGestureRecognizer(tapGesture)
        }
    }

    private var user: User?

    // MARK: - LifeCycle

    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
    }

    // MARK: - Selectors

    @objc func avatarImageViewTapped() {
        guard let user = user else { return }

        // 閲覧済みユーザーであることがわかるよう枠線の色を変更
        wrapperView.layer.borderColor = UIColor.lightGray.cgColor

        // FIXME: 親のViewControllerを取得して遷移する
        if let parentVC = self.parentViewController() {
            let profileVC = ProfileViewController(user: user)
            parentVC.navigationController?.pushViewController(profileVC, animated: true)
        }
    }

    // MARK: - Helpers

    func configure(user: User) {
        self.user = user
        guard let imageName = user.image else { return }
        let image = UIImage.named(imageName)
        avatarImageView.image = image
    }

    private func configureUI() {
        wrapperView.layer.borderColor = UIColor.systemRed.cgColor
        wrapperView.layer.borderWidth = 2
        wrapperView.layer.cornerRadius = wrapperView.frame.height / 2
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
    }

}
