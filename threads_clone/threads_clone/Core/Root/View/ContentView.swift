//
//  ContentView.swift
//  threads_clone
//
//  Created by Mizuno Hikaru on 2024/01/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        Group {
            // ログイン中
            if viewModel.userSession != nil {
                ThreadsTabView()
            } 
            // ログアウト中
            else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
