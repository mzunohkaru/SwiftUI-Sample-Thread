//
//  ThreadDetailsViewModel.swift
//  threads_clone
//
//  Created by Mizuno Hikaru on 2024/02/01.
//

import Foundation

@MainActor
class ThreadDetailsViewModel: ObservableObject {
    
    @Published var replies = [ThreadReply]()
    
    private let thread: Thread
    
    init(thread: Thread) {
        self.thread = thread
        Task {
            try await fetchThreadReplies()
        }
    }
    
    private func fetchThreadReplies() async throws {
        self.replies = try await ThreadReplyService.fetchThreadReplies(forThread: thread)
        try await fetchUserDataForReplies()
    }
    
    private func fetchUserDataForReplies() async throws {
        for i in 0 ..< replies.count {
            let reply = replies[i]
            
            async let user = try await UserService.fetchUser(withUid: reply.threadReplyOwnerUid)
            self.replies[i].replyUser = try await user
        }
    }
}
