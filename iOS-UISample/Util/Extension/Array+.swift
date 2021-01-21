//
// Created by nagisa miura on 2021/01/04.
//

import Foundation

extension Array {

    /// guard文を強制し、安全な配列アクセスを行うための処理
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
