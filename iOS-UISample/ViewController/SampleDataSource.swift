//
//  SampleDataSource.swift
//  iOS-UISample
//
//  Created by nagisa miura on 2022/03/28.
//

import UIKit

protocol SampleDataSourceProtocol: NSObject {
    func didSelectDelete(_ dataSource: SampleDataSource, indexPath: IndexPath)
}

final class SampleDataSource: UITableViewDiffableDataSource<SampleSection, SampleItem> {

    weak var delegate: SampleDataSourceProtocol?

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        guard let section = SampleSection(rawValue: indexPath.section) else { return false }
        switch section {
        case .list:
            return true
        case .button:
            return false
        }
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let section = SampleSection(rawValue: indexPath.section) else { return }
        switch section {
        case .list:
            if editingStyle == .delete {
                delegate?.didSelectDelete(self, indexPath: indexPath)
            }
        case .button:
            break
        }
    }
}

enum SampleSection: Int, CaseIterable {
    case list
    case button
}

enum SampleItem: Hashable {
    case list(fruit: Fruit)
    case button
}
