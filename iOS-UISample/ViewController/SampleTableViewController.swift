//
//  SampleTableViewController.swift
//  iOS-UISample
//
//  Created by nagisa miura on 2021/01/20.
//

import UIKit

// 影響範囲の限定に加えパフォーマンスの向上もできるので、基本final付与
// 参考: https://zenn.dev/k_koheyi/articles/b7745d4d277952579733
final class SampleTableViewController: UIViewController {

    // MARK: - Properties

    // デフォルトでinternalなため忘れがちだがIBOutletもprivate推奨
    // 参考: https://cocoacasts.com/tips-and-tricks-why-you-should-default-to-private-outlets
    @IBOutlet weak private var tableView: UITableView! {

        // willSet/didSetで構成しておくと、可視性があがる
        // 加えてライフサイクルを意識したレイアウト設定の記述を強制できる
        // 但し、View初期化時にしか設定できない項目はXIB側で行う必要がある(例: TableViewのgrouped)
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.rowHeight = SampleTableViewCell.height
            tableView.separatorStyle = .none

            // TableViewにヘッダーを登録
            tableView.register(SampleTableHeaderView.self,
                               forHeaderFooterViewReuseIdentifier: headerClassName)

            // TableViewにセルを登録
            let cellNib = UINib(nibName: cellClassName, bundle: nil)
            tableView.register(cellNib, forCellReuseIdentifier: cellClassName)

            // リフレッシュの設定
            tableView.refreshControl = refreshControl
            refreshControl.addTarget(self,
                                     action: #selector(self.refresh(sender:)),
                                     for: .valueChanged)
        }
    }

    @IBOutlet weak private var postButton: UIButton!

    @IBAction private func postButtonTapped(_ sender: Any) {
        postButtonTappedHandler()
    }

    private let headerClassName = SampleTableHeaderView.identifier
    private let cellClassName = SampleTableViewCell.identifier

    private let api = UserAPI()

    private let refreshControl = UIRefreshControl()

    private var users = [User]()

    private var header: SampleTableHeaderView?

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        fetchUsers()
    }

    /// AutoLayoutによる画面サイズ決定後に実行したい処理をここで記述する
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureUI()
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
            self.tableView.reloadData()
        }
    }

    // MARK: - Helpers

    private func configureNavigationItem() {
        navigationItem.title = "TableViewSample"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "戻る", style: .plain,
                                                           target: nil, action: nil)
    }

    private func configureUI() {
        postButton.layer.cornerRadius = postButton.frame.height / 2
    }

    private func postButtonTappedHandler() {
        print("postButtonがタップされたよ")
    }
}

// MARK: - UITableViewDelegate

extension SampleTableViewController: UITableViewDelegate {

    /// セルをタップしたときに呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let user = users[safe: indexPath.row] else { return }
        let vc = ProfileViewController(user: user)
        navigationController?.pushViewController(vc, animated: true)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellClassName,
                                                 for: indexPath) as! SampleTableViewCell
        guard let user = users[safe: indexPath.row] else { return cell }
        cell.configure(user: user)
        return cell
    }

    /// ヘッダーの高さを設定する
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return SampleTableHeaderView.height
    }

    /// ヘッダーの中身を設定する
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // 強制アンラップが許容される事例
        // 参考: https://stackoverflow.com/questions/34383679/best-practice-for-initialising-uitableviewcells-in-swift
        let header = tableView
            .dequeueReusableHeaderFooterView(withIdentifier: headerClassName) as! SampleTableHeaderView

        // ヘッダーが作成されるタイミングでdelegateの設定
        header.delegate = self
        self.header = header
        return header
    }
}

// MARK: - SampleTableHeaderViewDelegate

extension SampleTableViewController: SampleTableHeaderViewDelegate {

    /// セルタップ時に呼ばれるDelgateメソッド
    func didTapProfileImage(_ header: SampleTableHeaderView, didSelectUser user: User) {
//        let vc = ProfileViewController(user: user)
//        navigationController?.pushViewController(vc, animated: true)
    }
}
