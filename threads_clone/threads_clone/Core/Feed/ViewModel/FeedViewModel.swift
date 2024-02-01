//
//  FeedViewModel.swift
//  threads_clone
//
//  Created by Mizuno Hikaru on 2024/01/24.
//

import Foundation

@MainActor
class FeedViewModel: ObservableObject {
    @Published var threads = [Thread]()
    
    init() {
        Task { try await fetchThreads() }
    }
    
    func fetchThreads() async throws {
        self.threads = try await ThreadService.fetchThreads()
        try await fetchUserDataForThreads()
    }
    
    // 各スレッドに所有者のユーザーデータを関連付ける
    private func fetchUserDataForThreads() async throws {
        for i in 0 ..< threads.count {
            let thread = threads[i]
            
            let ownerUid = thread.ownerUid
            // 指定したユーザーIDのユーザーデータを取得
            let threadUser = try await UserService.fetchUser(withUid: ownerUid)
            // 取得したユーザーデータを、現在のスレッドのuserプロパティに設定
            threads[i].user = threadUser
        }
    }
}
