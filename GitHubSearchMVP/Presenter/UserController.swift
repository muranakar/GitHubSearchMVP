//
//  UserController.swift
//  GitHubSearchMVP
//
//  Created by 村中令 on 2023/05/26.
//

import Foundation

/// イベントの制御を行う構造体
struct UserController {
    let model: GithubModel
    let query: String

    /// Modelにロード開始を要求する
    public func loadStart() async throws {
        do {
            await model.fetchUser(query: query)
        }
    }
}
