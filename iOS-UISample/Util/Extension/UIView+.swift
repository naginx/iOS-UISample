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

    /// UIViewから親のViewControllerを取得する処理
    /// 引用: https://qiita.com/tetsukick/items/ae05fdc6040c491639a2
    func parentViewController() -> UIViewController? {
        var parentResponder: UIResponder? = self
        while true {
            guard let nextResponder = parentResponder?.next else { return nil }
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            parentResponder = nextResponder
        }
    }
}
