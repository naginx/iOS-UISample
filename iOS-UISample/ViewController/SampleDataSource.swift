//
//  SampleDataSource.swift
//  iOS-UISample
//
//  Created by nagisa miura on 2022/03/28.
//

import UIKit

enum SampleSection: Hashable, Equatable {
    case itemSection(row: SampleItem)
    case button

    func hash(into hasher: inout Hasher) {
        switch self {
        case .itemSection(let row):
            hasher.combine(row.hashValue)
        case .button:
            break
        }
    }

}

enum SampleItem: Hashable, Equatable {
    case itemRow(fruit: Fruit)
    case button

    func hash(into hasher: inout Hasher) {
        switch self {
        case .itemRow(let fruit):
            hasher.combine(fruit.uuid)
        case .button:
            break
        }
    }

    static func ==(lhs: SampleItem, rhs: SampleItem) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}


protocol SampleDataSourceDelegate: AnyObject {
    func didSelectDelete(_ dataSource: SampleDataSource, indexPath: IndexPath)
}

final class SampleDataSource: UITableViewDiffableDataSource<SampleSection, SampleItem> {

    weak var delegate: SampleDataSourceDelegate?

    private var viewModel: DiffableTableViewModel

    init(viewModel: DiffableTableViewModel, tableView: UITableView,
         cellProvider: @escaping UITableViewDiffableDataSource<SampleSection, SampleItem>.CellProvider) {
        self.viewModel = viewModel
        super.init(tableView: tableView, cellProvider: cellProvider)
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let section = viewModel.sectionList[indexPath.section]
        switch section {
        case .itemSection:
            return true
        case .button:
            return false
        }
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let section = viewModel.sectionList[indexPath.section]
            switch section {
            case .itemSection:
                delegate?.didSelectDelete(self, indexPath: indexPath)
                break
            case .button:
                break
            }
        case .insert:
            break
        case .none:
            break
        @unknown default:
            break
        }
    }
}
