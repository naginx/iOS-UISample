//
//  Fruit.swift
//  iOS-UISample
//
//  Created by nagisa miura on 2022/03/30.
//

import Foundation

/// 参考: https://techlife.cookpad.com/entry/2020/12/24/130000
///       https://qiita.com/hironytic/items/8a3a73e571bd047124a3
struct Fruit: Hashable, Equatable {

    let uuid: UUID = UUID()
    var name: String
    var isFavorite: Bool

    init(name: String, isFavorite: Bool) {
        self.name = name
        self.isFavorite = isFavorite
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }

    static func ==(lhs: Fruit, rhs: Fruit) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
