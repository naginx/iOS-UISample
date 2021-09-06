//
//  ReverseTableViewController.swift
//  iOS-UISample
//
//  Created by nagisa miura on 2021/09/06.
//

import ReverseExtension
import UIKit

final class ReverseTableViewController: UIViewController {

    typealias Cell = SampleTableViewCell
    private let api = UserAPI()

    private var users = [User]()

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.re.dataSource = self
            tableView.re.delegate = self
            tableView.register(type: Cell.self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchUsers()
    }

    private func fetchUsers() {

        // API通信の直前にリフレッシュを開始
        api.getUsers { (users, error) in
            // 通信完了直後にリフレッシュを停止
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
            self.tableView.reloadData()
        }
    }
}

extension ReverseTableViewController: UITableViewDelegate {

}

extension ReverseTableViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withReuseCell: Cell.self, for: indexPath)
        cell.configure(user: users[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
}
