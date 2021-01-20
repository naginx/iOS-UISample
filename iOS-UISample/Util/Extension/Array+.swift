//
// Created by nagisa miura on 2021/01/04.
//

import Foundation

extension Array {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
