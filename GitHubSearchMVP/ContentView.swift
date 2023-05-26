//
//  ContentView.swift
//  GitHubSearchMVP
//
//  Created by 村中令 on 2023/05/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            UserSearchView()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
