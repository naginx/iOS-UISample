//
//  UIView+.swift
//  iOS-UISample
//
//  Created by nagisa miura on 2021/01/20.
//

import UIKit

extension UIView {

    /// クラス名を文字列で返す
    static var className: String { String(describing: Self.self) }

    /// addSubviewを配列でまとめて行うための処理
    func addSubviews(_ views: [UIView]) {
        views.forEach { view in
            addSubview(view)
        }
    }

    /// nibファイルからUIViewの読み込みを行う
    func loadNib() {
        guard let view = Bundle.main.loadNibNamed(Self.className, owner: self, options: nil)?.first as? UIView
        else { fatalError("Failed to loadNib.") }
        view.frame = self.bounds
        self.addSubview(view)
    }
}
