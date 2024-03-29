//
//  RepositoryRow.swift
//  GitHubSearchMVP
//
//  Created by 村中令 on 2023/05/26.
//

import SwiftUI

struct RepositoryRow: View {
    let repository: Repository

    var body: some View {
        VStack {
            HStack {
                Text(repository.name)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                Spacer()
            }
            .padding()
            HStack {
                Text(repository.description ?? "")
                    .font(.caption)
                Spacer()
            }
            HStack {
                Text(repository.language ?? "")
                Spacer()
                Image(systemName: "star.fill")
                Text(String(repository.stargazersCount))
                Spacer()
                Text("falk: \(String(repository.forksCount))")
                Spacer()
            }
            .padding()
        }
        .padding()
    }
}

struct RepositoryRow_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryRow(repository: Repository.mock)
    }
}
