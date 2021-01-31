//
//  UIView+.swift
//  iOS-UISample
//
//  Created by nagisa miura on 2021/01/20.
//

import UIKit

extension UIView {

    /// 識別子をクラス名から算出して返せるように
    static var identifier: String { String(describing: Self.self) }

    /// addSubviewを配列でまとめて行うための処理
    func addSubviews(_ views: [UIView]) {
        views.forEach { view in
            addSubview(view)
        }
    }
}
