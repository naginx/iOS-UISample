//
//  UIImage+.swift
//  TwitterTutorial
//
//  Created by nagisa miura on 2021/01/06.
//

import UIKit

extension UIImage {

    /// ローカルファイル指定でのUIImage初期化処理から、強制アンラップをなくすための処理
    static func named(_ name: String) -> UIImage {
        if let image = UIImage(named: name) {
            return image
        } else {
            fatalError("Could not initialize \(UIImage.self) named \(name).")
        }
    }
}
