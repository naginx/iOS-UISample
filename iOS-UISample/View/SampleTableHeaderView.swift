//
//  SampleTableHeaderView.swift
//  iOS-UISample
//
//  Created by nagisa miura on 2021/01/20.
//

import SnapKit
import UIKit

protocol SampleTableHeaderViewDelegate: AnyObject {
    func sampleTableHeaderView(_ header: SampleTableHeaderView, didSelect user: User)
}

final class SampleTableHeaderView: UITableViewHeaderFooterView {

    // MARK: - Properties

    weak var delegate: SampleTableHeaderViewDelegate?

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "おすすめのユーザー"
        label.textColor = .lightGray
        return label
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let size: CGFloat = 72
        layout.itemSize = CGSize(width: size, height: size)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .white

        let cellNib = UINib(nibName: cellClassName, bundle: nil)
        cv.register(cellNib, forCellWithReuseIdentifier: cellClassName)
        return cv
    }()

    static let height: CGFloat = 100

    private let cellClassName = SampleTableHeaderCollectionViewCell.identifier

    private let refreshControl = UIRefreshControl()

    private let api = UserAPI()

    private var users = [User]()

    // MARK: - LifeCycle

    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
        refresh()
    }

    // MARK: - Selectors

    @objc func refresh() {
        fetchUsers()
    }

    // MARK: - API

    private func fetchUsers() {

        // API通信の直前にリフレッシュを開始
        refreshControl.beginRefreshing()
        api.getUsers { (users, error) in
            // 通信完了直後にリフレッシュを停止
            self.refreshControl.endRefreshing()
            if let error = error {
                print("エラーが発生しました: \(error)")
                return
            }

            guard let users = users else {
                print("レスポンスの取得に失敗しました")
                return
            }

            self.users = users

            // データの変更を反映させるためにリロード
            self.collectionView.reloadData()
        }
    }

    // MARK: - Helpers

    private func configureUI() {
        let views: [UIView] = [titleLabel, collectionView]
        contentView.addSubviews(views)

        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(14)
            make.top.equalTo(contentView.snp.top).offset(4)
            make.right.equalTo(contentView.snp.right)
            make.left.equalTo(contentView.snp.left).offset(4)
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.right.equalTo(contentView.snp.right)
            make.bottom.equalTo(contentView.snp.bottom)
            make.left.equalTo(contentView.snp.left)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension SampleTableHeaderView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return users.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellClassName,
                                                      for: indexPath) as! SampleTableHeaderCollectionViewCell
        guard let user = users[safe: indexPath.row] else { return cell }
        cell.delegate = self
        cell.configure(withUser: user)
        return cell
    }
}

// MARK: - SampleTableHeaderCollectionViewCellDelegate

extension SampleTableHeaderView: SampleTableHeaderCollectionViewCellDelegate {

    /// ヘッダーのセルタップ時にViewのデリゲートを経由して呼ばれる
    func sampleTableHeaderCollectionViewCell(_ cell: SampleTableHeaderCollectionViewCell, didSelect user: User) {
        delegate?.sampleTableHeaderView(self, didSelect: user)
    }
}
