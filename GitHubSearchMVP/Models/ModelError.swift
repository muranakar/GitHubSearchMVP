//
//  ModelError.swift
//  GitHubSearchMVP
//
//  Created by 村中令 on 2023/05/26.
//

import Foundation

/// APIを叩く際に発生する可能性のあるエラー一覧
enum ModelError: Error {
    case urlError
    case responseError(Error)
    case responseDataEmpty
    case jsonParseError(String)

    var localizedDescription: String {
        switch self {
        case .urlError: return "URLに変換しようとしたところで失敗しました"
        case .responseError(let error): return "API叩いたらエラーが返ってきました。詳細: （\(error)）"
        case .responseDataEmpty: return "APIから取得したデータがnilでした"
        case .jsonParseError(let message): return "JSONのパースに失敗しました。失敗したデータ: (\(message)"
        }
    }
}
