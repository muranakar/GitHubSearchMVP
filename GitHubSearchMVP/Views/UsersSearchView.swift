//
//  UsersSearchView.swift
//  GitHubSearchMVP
//
//  Created by 村中令 on 2023/05/26.
//

import SwiftUI

struct UserSearchView: View {
    @State private var searchText: String = ""
    @ObservedObject var model = GithubModel()

    var body: some View {
        NavigationView {
            VStack {
                TextField("user name", text: $searchText)
                    .onChange(of: searchText) { _ in
                        Task {
                            try await UserController(model: model, query: searchText).loadStart()
                        }

                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.asciiCapable)
                    .padding()
                Spacer()
                if let error = model.error {
                    Text(error.localizedDescription)
                } else {
                    if model.isNotFound {
                        Text("user not found")
                    } else {
                        List(model.users) { user in
                            NavigationLink(destination: RepositoryView(repositoryUrlString: user.reposUrl)) {
                                UserRow(user: user)
                            }
                        }
                        .refreshable {
                            Task{
                                try await                             UserController(model: model, query: searchText).loadStart()

                            }
                        }
                    }
                }
                Spacer()
            }
            .navigationTitle("🔍Search Github User")
        }
    }
}

struct UsersSearchView_Previews: PreviewProvider {
    static var previews: some View {
        UserSearchView()
    }
}
