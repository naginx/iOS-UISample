//
//  UserAPI.swift
//  iOS-UISample
//
//  Created by nagisa miura on 2021/01/20.
//

import Foundation

final class UserAPI {

    /// APIの代わりに2秒待ってからユーザーのリストを返す処理
    func getUsers(completion: (([User]?, Error?) -> Void)? = nil) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
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
    func userData() -> Data {
        let json =
            """
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
                }
            ]
            """
        guard let jsonData = json.data(using: .utf8) else { return Data() }
        return jsonData
    }
}
