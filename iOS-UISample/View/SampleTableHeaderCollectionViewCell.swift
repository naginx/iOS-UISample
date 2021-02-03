//
//  SampleTableHeaderCollectionViewCell.swift
//  iOS-UISample
//
//  Created by nagisa miura on 2021/01/29.
//

import UIKit

protocol SampleTableHeaderCollectionViewCellDelegate: AnyObject {
    func sampleTableHeaderCollectionViewCell(_ cell: SampleTableHeaderCollectionViewCell, didSelect user: User)
}

final class SampleTableHeaderCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties

    weak var delegate: SampleTableHeaderCollectionViewCellDelegate?

    @IBOutlet weak private var wrapperView: UIView! {
        didSet {
            wrapperView.clipsToBounds = true
        }
    }

    // UIButtonにするとスクロールイベントと重複して、
    // スクロールが動作しないため、ImageViewのジェスチャーで設定
    @IBOutlet weak private var thumbnailView: UIImageView! {
        didSet {
            thumbnailView.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(
                target: self,
                action: #selector(cellTapped))
            thumbnailView.addGestureRecognizer(tapGesture)
        }
    }

    private var user: User?

    // MARK: - LifeCycle

    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
    }

    // MARK: - Selectors

    @objc func cellTapped() {
        guard let user = user else { return }

        // 閲覧済みユーザーであることがわかるよう枠線の色を変更
        wrapperView.layer.borderColor = UIColor.lightGray.cgColor

        // イベントを伝播
        delegate?.sampleTableHeaderCollectionViewCell(self, didSelect: user)
    }

    // MARK: - Helpers

    func configure(withUser: User) {
        self.user = withUser
        guard let imageName = withUser.image else { return }
        let image = UIImage.named(imageName)
        thumbnailView.image = image
    }

    private func configureUI() {
        DispatchQueue.main.async {
            self.wrapperView.layer.cornerRadius = self.wrapperView.bounds.height / 2
            self.wrapperView.layer.borderColor = UIColor.systemRed.cgColor
            self.wrapperView.layer.borderWidth = 2

            self.thumbnailView.layer.borderColor = UIColor.white.cgColor
            self.thumbnailView.layer.borderWidth = 2
        }
    }
}
