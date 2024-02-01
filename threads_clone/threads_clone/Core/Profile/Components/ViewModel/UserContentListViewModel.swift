//
//  UserContentListViewModel.swift
//  threads_clone
//
//  Created by Mizuno Hikaru on 2024/01/24.
//

import Foundation

@MainActor
class UserContentListViewModel: ObservableObject {
    
    @Published var threads = [Thread]()
    @Published var replies = [ThreadReply]()
    
    let user: User
    
    init(user: User) {
        self.user = user
        
        // タスクが並行して実行される
        Task { try await fetchUserThreads() }
        Task { try await fetchUserReplies() }
    }
    
    func fetchUserThreads() async throws {
        self.threads = try await ThreadService.fetchUserThreads(uid: user.id)
        
        for i in 0 ..< threads.count {
            threads[i].user = self.user
        }
        
        self.threads = threads
    }
    
    func fetchUserReplies() async throws {
        self.replies = try await ThreadService.fetchThreadReplies(forUser: user)
        
        try await fetchReplyThreadData()
    }
    
    func fetchReplyThreadData() async throws {
        for i in 0 ..< replies.count {
            let reply = replies[i]
            
            // reply に含まれる threadId に基づいて thread を取得
            var thread = try await ThreadService.fetchThread(threadId: reply.threadId)
            // 取得した thread のuserプロパティを更新
            thread.user = try await UserService.fetchUser(withUid: thread.ownerUid)
            // reply の threadプロパティに設定
            replies[i].thread = thread
        }
    }
}
