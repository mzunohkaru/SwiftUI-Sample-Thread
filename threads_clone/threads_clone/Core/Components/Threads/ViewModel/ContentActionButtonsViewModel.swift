//
//  ContentActionButtonsViewModel.swift
//  threads_clone
//
//  Created by Mizuno Hikaru on 2024/02/01.
//

import Foundation

@MainActor
class ContentActionButtonsViewModel: ObservableObject {
    
    @Published var thread: Thread
    
    init(thread: Thread) {
        self.thread = thread
        Task { try await checkIfUserLikedThread() }
    }
    
    func likeThread() async throws {
        try await ThreadService.likeThread(thread)
        self.thread.didLike = true
        self.thread.likes += 1
    }
    
    func unlikeThread() async throws {
        try await ThreadService.unlikeThread(thread)
        self.thread.didLike = false        
        self.thread.likes -= 1
    }
    
    func checkIfUserLikedThread() async throws {
        let didLike = try await ThreadService.checkIfUserLikedThread(thread)
        
        // only execute update if thread has beel liked
        if didLike {
            self.thread.didLike = true
        }
    }
}
