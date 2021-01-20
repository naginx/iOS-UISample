//
//  User.swift
//  iOS-UISample
//
//  Created by nagisa miura on 2021/01/20.
//

import Foundation

struct User: Codable {
    let id: Int
    var name: String
    var age: Int
    var image: String?
    var message: String?
}
