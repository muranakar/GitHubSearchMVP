//
//  GithubModel.swift
//  GitHubSearchMVP
//
//  Created by 村中令 on 2023/05/26.
//

import Foundation

/// Modelオブジェクトが準拠するプロトコル
protocol SearchUserModelInput {
    /// QueryをもとにGithubのユーザー検索APIを叩いて、結果をcallbackする
    func fetchUser(query: String) async
    /// Githubのあるユーザーのリポジトリ一覧を取得して、結果をcallbackする
    func fetchRepositories(urlString: String) async
}

/// GithubのREST APIを叩いて、結果を返すクラス
class GithubModel: SearchUserModelInput ,ObservableObject{
    @Published var users = [User]()
    @Published var isNotFound = false

    @Published var repositories = [Repository]()
    @Published var isLoading = true

    @Published var error: ModelError?
    
    private var endpoint: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        return components
    }

    func fetchUser(query: String) async {
        guard !query.isEmpty,
              let url = userSearchEndpoint(query: query) else {
            error = ModelError.urlError
            return
        }
        do {
            let data = try await fetch(url: url)
            guard let users = try? JSONDecoder().decode(Users.self, from: data) else {
                error = ModelError.jsonParseError(String(data: data, encoding: .utf8) ?? "")
                return}
            self.users = users.items
        } catch let error as ModelError {
            self.error = error
        } catch {

        }
    }


func fetchRepositories(urlString: String) async {
    guard let url = URL(string: urlString) else {
        error = ModelError.urlError
        return
    }

    do {
        let data = try await fetch(url: url)
        guard let repositories = try? JSONDecoder().decode([Repository].self, from: data) else {
            error = ModelError.jsonParseError(String(data: data, encoding: .utf8) ?? "")
            return
        }
        self.repositories = repositories
    } catch let error as ModelError {
        self.error = error
    } catch {

    }
}

private func userSearchEndpoint(query: String) -> URL? {
    guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else {
        return nil
    }

    var urlComponents = endpoint
    urlComponents.path = "/search/users"
    urlComponents.queryItems = [URLQueryItem(name: "q", value: encodedQuery)]
    guard let url = urlComponents.url else {
        return nil
    }

    return url
}

@MainActor
private func fetch(url: URL) async throws -> Data {
    do {
        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
        return data
    } catch {
        throw ModelError.urlError
    }
}
}
