//
//  DiffableTableViewController.swift
//  iOS-UISample
//
//  Created by nagisa miura on 2022/03/15.
//

import UIKit

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
        let grape = Fruit(name: "ぶどう", isFavorite: false)
        fruits.append(grape)
        snapshot.appendItems([grape], toSection: .list)
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
        snapshot.appendItems(fruits, toSection: .list)
        snapshot.appendItems([Fruit(name: "ボタン", isFavorite: true)], toSection: .button)
        dataSource.apply(snapshot)
        return nil
    }()

    // MARK: DiffableDataSource

    private enum Section: Int, CaseIterable {
        case list
        case button
    }

    private lazy var dataSource: UITableViewDiffableDataSource<Section, Fruit> = {
        let dataSource = UITableViewDiffableDataSource<Section, Fruit>(tableView: tableView, cellProvider: cellProvider)
        dataSource.defaultRowAnimation = .fade
        return dataSource
    }()

    private lazy var snapshot = NSDiffableDataSourceSnapshot<Section, Fruit>()

    private func cellProvider(tableView: UITableView, indexPath: IndexPath, fruit: Fruit) -> UITableViewCell? {
        guard let section = Section(rawValue: indexPath.section) else { return nil }
        switch section {
        case .list:
            let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            cell.textLabel?.text = fruit.name + " / \(indexPath.row)"
            return cell
        case .button:
            let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            cell.textLabel?.text = fruit.name
            return cell
        }
    }
}

// MARK: - UITableViewDelegate

extension DiffableTableViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fruit = fruits[indexPath.row]
        fruits.remove(at: indexPath.row)
        snapshot.deleteItems([fruit])
        dataSource.apply(snapshot)
    }
}
