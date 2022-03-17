//
//  DiffableTableViewController.swift
//  iOS-UISample
//
//  Created by nagisa miura on 2022/03/15.
//

import UIKit

/// 参考: https://techlife.cookpad.com/entry/2020/12/24/130000

struct Fruit: Hashable {

    let id: UUID
    var name: String
    var isFavorite: Bool

    init(name: String, isFavorite: Bool) {
        self.id = UUID()
        self.name = name
        self.isFavorite = isFavorite
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

final class DiffableTableViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var createButton: UIButton!
    @IBOutlet private weak var fetchButton: UIButton!

    @IBAction private func tappedCreateButton(_ sender: UIButton) {
        createNewFruit()
    }

    private func createNewFruit() {
        let grape = Fruit(name: "ぶどう", isFavorite: false)
        fruits.append(grape)
        snapshot.appendItems([.list(fruit: grape)], toSection: .list)
        dataSource.apply(snapshot)
    }

    private var fruits: [Fruit] = [
        Fruit(name: "バナナ", isFavorite: false),
        Fruit(name: "りんご", isFavorite: true),
        Fruit(name: "メロン", isFavorite: false),
    ]

    // MARK: LifeCycle / Setup

    override func viewDidLoad() {
        super.viewDidLoad()
        _setup?()
    }

    private lazy var _setup: (() -> Void)? = {
        tableView.delegate = self
        snapshot.appendSections(Section.allCases)
        let fruitItems = fruits.map({ Item.list(fruit: $0) })
        snapshot.appendItems(fruitItems, toSection: .list)
        snapshot.appendItems([.button], toSection: .button)
        dataSource.apply(snapshot)
        return nil
    }()

    // MARK: DiffableDataSource

    private enum Section: Int, CaseIterable {
        case list
        case button
    }

    private enum Item: Hashable {
        case list(fruit: Fruit)
        case button
    }

    private lazy var dataSource: UITableViewDiffableDataSource<Section, Item> = {
        let dataSource = UITableViewDiffableDataSource<Section, Item>(tableView: tableView, cellProvider: cellProvider)
        dataSource.defaultRowAnimation = .fade
        return dataSource
    }()

    private lazy var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()

    private func cellProvider(tableView: UITableView, indexPath: IndexPath, item: Item) -> UITableViewCell? {
        switch item {
        case .list(let fruit):
            let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            cell.textLabel?.text = fruit.name + " / \(indexPath.row)"
            return cell
        case .button:
            let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            cell.textLabel?.text = "ボタン"
            return cell
        }
    }
}

// MARK: - UITableViewDelegate

extension DiffableTableViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section) else { return }
        switch section {
        case .list:
            // TODO: 削除の処理をiOSの赤ボタン出る方法に変える
            let fruit = fruits[indexPath.row]
            fruits.remove(at: indexPath.row)
            snapshot.deleteItems([.list(fruit: fruit)])
            dataSource.apply(snapshot)
        case .button:
            createNewFruit()
        }
    }
}
