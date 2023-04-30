//
//  UserListView.swift
//  iOS-UISample
//
//  Created by nagisa miura on 2021/02/07.
//

import UIKit

protocol UserListViewDelegate: AnyObject {
    func userListView(_ view: UserListView, didSelectUser user: User)
}

final class UserListView: UIView {

    // MARK: - Properties

    weak var delegate: UserListViewDelegate?

    var users = [User]() {
        didSet {
            refresh()
        }
    }

    lazy var refreshControl: UIRefreshControl = {
        let refresher = UIRefreshControl()
        refresher.addTarget(self,
                            action: #selector(refresh),
                            for: .valueChanged)
        return refresher
    }()

    private let cellClassName = UserCollectionViewCell.className

    @IBOutlet weak private var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self

            let cellNib = UINib(nibName: cellClassName, bundle: nil)
            collectionView.register(cellNib, forCellWithReuseIdentifier: cellClassName)
            collectionView.refreshControl = refreshControl
        }
    }

    // MARK: - LifeCycle

    required init() {
        super.init(frame: CGRect.zero)
        loadNib()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.backgroundColor = .lightGray
        collectionView.makeColumnLayout(column: 3, interMargin: 4, outerMargin: 8, aspectRatio: 1.6)
    }

    // MARK: - Helpers

    @objc func refresh() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDelegate

extension UserListView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let user = users[safe: indexPath.row] else { return }
        delegate?.userListView(self, didSelectUser: user)
    }
}

// MARK: - UICollectionViewDataSource

extension UserListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return users.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellClassName,
                                                      for: indexPath) as! UserCollectionViewCell
        guard let user = users[safe: indexPath.row] else { return cell }
        cell.configure(user: user)
        return cell
    }
}
