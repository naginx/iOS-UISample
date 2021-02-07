//
//  SampleCollectionViewController.swift
//  iOS-UISample
//
//  Created by nagisa miura on 2021/02/06.
//

import UIKit

final class SampleCollectionViewController: UIViewController {

    // MARK: - Properties

    private let cellClassName = SampleCollectionViewCell.identifier

    private let collectionViewSideMargin = 8

    @IBOutlet weak private var sampleCollectionView: UICollectionView! {
        didSet {
            sampleCollectionView.delegate = self
            sampleCollectionView.dataSource = self

            let cellNib = UINib(nibName: cellClassName, bundle: nil)
            sampleCollectionView.register(cellNib, forCellWithReuseIdentifier: cellClassName)

            sampleCollectionView.refreshControl = refreshControl
            refreshControl.addTarget(self,
                                     action: #selector(self.refresh),
                                     for: .valueChanged)

            let layout = UICollectionViewFlowLayout()
            layout.minimumLineSpacing = 2
            sampleCollectionView.collectionViewLayout = layout
        }
    }

    private var users = [User]()
    private let api = UserAPI()
    private let refreshControl = UIRefreshControl()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        fetchUsers()
    }

    // MARK: - Selectors

    @objc func refresh(sender: UIRefreshControl) {
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
            self.sampleCollectionView.reloadData()
        }
    }

    // MARK: - Helpers

    private func configureNavigationItem() {
        navigationItem.title = "CollectionViewSample"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "戻る", style: .plain,
                                                           target: nil, action: nil)
    }

}

// MARK: - UICollectionViewDelegate

extension SampleCollectionViewController: UICollectionViewDelegate {}

// MARK: - UICollectionViewDataSource

extension SampleCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return users.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = sampleCollectionView.dequeueReusableCell(withReuseIdentifier: cellClassName,
                                                            for: indexPath) as! SampleCollectionViewCell
        guard let user = users[safe: indexPath.row] else { return cell }
        cell.configure(user: user)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension SampleCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width / 2 - 10
        return CGSize(width: width, height: width * 1.2)
    }
}
