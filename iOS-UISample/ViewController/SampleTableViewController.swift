//
//  SampleTableViewController.swift
//  iOS-UISample
//
//  Created by nagisa miura on 2021/01/20.
//

import UIKit

final class SampleTableViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet weak private var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.rowHeight = 60
            tableView.separatorStyle = .none

            // クラス名を指定してxibファイルを読み込み、tableViewに使用するセルとして登録する
            let cellClassName = SampleTableViewCell.reuseIdentifier
            let cellNib = UINib(nibName: cellClassName, bundle: nil)
            tableView.register(cellNib, forCellReuseIdentifier: cellClassName)

            // リフレッシュの設定
            tableView.refreshControl = refreshControl
            refreshControl.addTarget(self,
                                     action: #selector(self.refresh(sender:)),
                                     for: .valueChanged)
        }
    }

    private let api = UserAPI()

    /// リフレッシュ設定のための変数
    private let refreshControl = UIRefreshControl()

    private var users = [User]()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "TableViewSample"
        fetchUsers()
    }

    // MARK: - Selectors

    @objc func refresh(sender: UIRefreshControl) {
        fetchUsers()
    }

    // MARK: - API

    private func fetchUsers() {
        refreshControl.beginRefreshing()
        api.getUsers { (users, error) in
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
            self.tableView.reloadData()
        }
    }

    // MARK: - Helpers

}

// MARK: - UITableViewDelegate

extension SampleTableViewController: UITableViewDelegate {

    /// セルをタップしたときに呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let user = users[safe: indexPath.row] else { return }
        print(user.name)
    }
}

// MARK: - UITableViewDataSource

extension SampleTableViewController: UITableViewDataSource {

    /// セルの数を決定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    /// セルの中身を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SampleTableViewCell.reuseIdentifier,
                                                 for: indexPath) as! SampleTableViewCell
        guard let user = users[safe: indexPath.row] else { return cell }
        cell.configure(user: user)
        return cell
    }
}
