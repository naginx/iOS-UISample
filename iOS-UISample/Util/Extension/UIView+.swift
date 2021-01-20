//
//  UIView+.swift
//  iOS-UISample
//
//  Created by nagisa miura on 2021/01/20.
//

import UIKit

extension UIView {

    /// reuseIdentifierを取得する際に、クラス名から算出して返せるように
    static var reuseIdentifier: String { String(describing: Self.self) }
}
