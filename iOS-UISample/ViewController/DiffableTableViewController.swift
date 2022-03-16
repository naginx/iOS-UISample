//
//  DiffableTableViewController.swift
//  iOS-UISample
//
//  Created by nagisa miura on 2022/03/15.
//

import UIKit

struct Fruit: Equatable {

    let id: UUID
    var name: String
    var isFavorite: Bool

    init(name: String, isFavorite: Bool) {
        self.id = UUID()
        self.name = name
        self.isFavorite = isFavorite
    }
}

final class DiffableTableViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
        }
    }

    var fruits: [Fruit] = [
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
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(items, toSection: .list)
        dataSource.apply(snapshot, animatingDifferences: false)
        return nil
    }()

    // MARK: DiffableDataSource

    private enum Section: CaseIterable {
        case list, button
    }

    private struct Item: Hashable {
        let fruitId: UUID
    }

    private var items: [Item] {
        fruits.sorted(by: { $0.name < $1.name })
            .map({ Item(fruitId:  $0.id )})
    }

    private lazy var dataSource: UITableViewDiffableDataSource<Section, Item> = {
        let dataSource = UITableViewDiffableDataSource<Section, Item>(tableView: tableView, cellProvider: cellProvider)
        dataSource.defaultRowAnimation = .fade
        return dataSource
    }()

    private lazy var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()

    private func cellProvider(tableView: UITableView, indexPath: IndexPath, item: Item) -> UITableViewCell? {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        let id = items[indexPath.row].fruitId
        let fruit = fruits.first(where: { $0.id == id })
        cell.textLabel?.text = fruit?.name
        return cell
    }
}

extension DiffableTableViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        snapshot.deleteItems([item])
        dataSource.apply(snapshot)
    }
}
