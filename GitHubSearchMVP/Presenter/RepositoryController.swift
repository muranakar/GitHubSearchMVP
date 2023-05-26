//
//  RepositoryController.swift
//  GitHubSearchMVP
//
//  Created by 村中令 on 2023/05/26.
//

import Foundation
/// イベントの制御を行う構造体
struct RepositoryController {
    let model: GithubModel
    let urlString: String

    /// Modelにロード開始を要求する
    public func loadStart() async throws {
        do {
            try await model.fetchRepositories(urlString: urlString)
        }
    }

}
