//
//  UserListViewController.swift
//  iOS-UISample
//
//  Created by nagisa miura on 2021/02/06.
//

import UIKit

final class UserListViewController: UIViewController {

    // MARK: - Properties

    private let api = UserAPI()

    private var users = [User]() {
        didSet {
            customView.users = users
            customView.refresh()
        }
    }

    private lazy var customView: UserListView = {
        let cv = self.view as! UserListView
        cv.delegate = self
        return cv
    }()

    // MARK: - LifeCycle

    override func loadView() {
        self.view = UserListView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        fetchUsers()
    }

    // MARK: - API

    private func fetchUsers() {
        customView.refreshControl.beginRefreshing()
        api.getUsers { (users, error) in
            self.customView.refreshControl.endRefreshing()
            if let error = error {
                print("エラーが発生しました: \(error)")
                return
            }
            guard let users = users else {
                print("レスポンスの取得に失敗しました")
                return
            }

            self.users = users
        }
    }

    // MARK: - Helpers

    private func configureNavigationItem() {
        navigationItem.title = "CollectionViewSample"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "戻る", style: .plain,
                                                           target: nil, action: nil)
    }
}

// MARK: - UserListViewDelegate

extension UserListViewController: UserListViewDelegate {

    func userListView(_ view: UserListView, didSelectUser user: User) {
        // TODO: 遷移処理を切り出す
        let vc = ProfileViewController(user: user)
        navigationController?.pushViewController(vc, animated: true)
    }
}
