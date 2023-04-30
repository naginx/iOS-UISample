//
//  UITableView+.swift
//  iOS-UISample
//
//  Created by nagisa miura on 2021/09/06.
//

import UIKit

extension UITableView {

    func register<T: UITableViewCell>(type: T.Type) {
        let nib = UINib(nibName: type.className, bundle: nil)
        register(nib, forCellReuseIdentifier: type.className)

    }

    func dequeueReusableCell<T: UITableViewCell>(withReuseCell type: T.Type, for indexPath: IndexPath) -> T {
        let cell = dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
        return cell
    }
}
