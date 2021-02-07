//
//  UserAPI.swift
//  iOS-UISample
//
//  Created by nagisa miura on 2021/01/20.
//

import Foundation

final class UserAPI {

    /// APIの代わりにn秒待ってからユーザーのリストを返す処理
    func getUsers(completion: (([User]?, Error?) -> Void)? = nil) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let jsonData = self.userData()

            // JSONのデコードで例外が発生する可能性があるため, do-catch
            do {
                let users = try JSONDecoder().decode([User].self, from: jsonData)
                completion?(users, nil)
            } catch {
                print(error)
                completion?(nil, error)
            }
        }
    }
}

private extension UserAPI {

    /// API呼び出しで返ってくることを想定したJSONデータ
    /// 画像引用元: https://www.pakutaso.com/model.html
    func userData() -> Data { // swiftlint:disable:this function_body_length
        let json = """
[
    {
        "id": 1,
        "name": "太郎",
        "age": 20,
        "image": "suits_man",
        "message": "はじめまして。よろしくお願いします!!"
    },
    {
        "id": 2,
        "name": "花子",
        "age": 16,
        "image": "snow_woman",
        "message": "ヨロシク！"
    },
    {
        "id": 3,
        "name": "次郎",
        "age": 14,
        "image": "base_man",
        "message": "Hello. I'm Jiro."
    },
    {
        "id": 4,
        "name": "梅子",
        "age": 17,
        "image": "christmas_girl",
        "message": "こんにちは！"
    },
    {
        "id": 5,
        "name": "竹子",
        "age": 18,
        "image": "manager_girl",
        "message": "暇だよー"
    },
    {
        "id": 6,
        "name": "松子",
        "age": 18,
        "image": "eat_girl",
        "message": "お腹すいた..."
    },
    {
        "id": 7,
        "name": "炭治郎",
        "age": 43,
        "image": "tasogare_man",
        "message": "寂しいです(泣)"
    },
    {
        "id": 8,
        "name": "君麻呂",
        "age": 28,
        "image": "battou_man",
        "message": "どうも"
    }
]
"""
        guard let jsonData = json.data(using: .utf8) else { return Data() }
        return jsonData
    }
}
