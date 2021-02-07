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

    private lazy var customView: UserListView = {
        return self.view as! UserListView
    }()

    private var users = [User]() {
        didSet {
            customView.users = users
            customView.refresh()
        }
    }

    // MARK: - LifeCycle

    override func loadView() {
        self.view = UserListView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        customView.delegate = self
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
        let vc = ProfileViewController(user: user)
        navigationController?.pushViewController(vc, animated: true)
    }
}
