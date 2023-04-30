//
//  DiffableTableViewController.swift
//  iOS-UISample
//
//  Created by nagisa miura on 2022/03/15.
//

import UIKit

final class DiffableTableViewModel {

    var fruits: [Fruit] = [
        Fruit(name: "バナナ", isFavorite: false),
        Fruit(name: "りんご", isFavorite: true),
        Fruit(name: "メロン", isFavorite: false),
    ]

    var sectionList: [SampleSection] {
        var list = fruits.map({
            SampleSection.itemSection(row: .itemRow(fruit: $0))
        })
        list.append(SampleSection.button)
        return list
    }
}


final class DiffableTableViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var createButton: UIButton!
    @IBOutlet private weak var deleteButton: UIButton!

    @IBAction private func tappedCreateButton(_ sender: UIButton) {
        createNewFruit()
    }

    @IBAction private func tappedDeleteButton(_ sender: UIButton) {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }

    private let viewModel = DiffableTableViewModel()

    private func createNewFruit() {
        let grape = Fruit(name: "ぶどう", isFavorite: false)
        viewModel.fruits.append(grape)
        let row = SampleItem.itemRow(fruit: grape)
        let section = SampleSection.itemSection(row: row)
        snapshot.insertSections([section], beforeSection: .button)
        snapshot.appendItems([row], toSection: section)
        dataSource.apply(snapshot)
    }

    // MARK: LifeCycle / Setup

    override func viewDidLoad() {
        super.viewDidLoad()
        _setup?()
    }

    private lazy var _setup: (() -> Void)? = {
        tableView.delegate = self
        snapshot.appendSections(viewModel.sectionList)
        for fruit in viewModel.fruits {
            let row = SampleItem.itemRow(fruit: fruit)
            snapshot.appendItems([row], toSection: .itemSection(row: row))
        }
        snapshot.appendItems([.button], toSection: .button)
        dataSource.apply(snapshot)
        return nil
    }()

    // MARK: DiffableDataSource

    private lazy var dataSource: SampleDataSource = {
        let dataSource = SampleDataSource(viewModel: viewModel, tableView: tableView, cellProvider: cellProvider)
        dataSource.defaultRowAnimation = .fade
        dataSource.delegate = self
        return dataSource
    }()

    private lazy var snapshot = NSDiffableDataSourceSnapshot<SampleSection, SampleItem>()

    private func cellProvider(tableView: UITableView, indexPath: IndexPath, item: SampleItem) -> UITableViewCell? {
        switch item {
        case .itemRow(let fruit):
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

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}

// MARK: - SampleDataSourceDelegate

extension DiffableTableViewController: SampleDataSourceDelegate {

    func didSelectDelete(_ dataSource: SampleDataSource, indexPath: IndexPath) {
        let fruit = viewModel.fruits[indexPath.section]
        viewModel.fruits.remove(at: indexPath.section)
        snapshot.deleteSections([.itemSection(row: .itemRow(fruit: fruit))])
        dataSource.apply(snapshot)
    }
}
