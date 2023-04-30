//
//  UIButton+.swift
//  iOS-UISample
//
//  Created by nagisa miura on 2023/04/30.
//

import UIKit

extension UIButton {
    func tap() {
        self.sendActions(for: .touchUpInside)
    }
}

