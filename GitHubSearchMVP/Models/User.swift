//
//  User.swift
//  GitHubSearchMVP
//
//  Created by 村中令 on 2023/05/26.
//

import Foundation

/// GithubのAPIが返すユーザーデータ。必要なプロパティのみを取得する
struct Users: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [User]

    private enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}

struct User: Codable, Identifiable {
    let id = UUID()
    let login: String
    let avatarUrl: String
    let reposUrl: String
    static let mockUser = User(login: "0si43",
                               avatarUrl: "https://avatars.githubusercontent.com/u/45909001?v=4",
                               reposUrl: "https://api.github.com/users/0si43/repos")

    private enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
        case reposUrl = "repos_url"
    }
}
