//
//  CreateThreadViewModel.swift
//  threads_clone
//
//  Created by Mizuno Hikaru on 2024/01/24.
//

import Firebase

class CreateThreadViewModel: ObservableObject {
    func uploadThread(caption: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let thread = Thread(ownerUid: uid, caption: caption, timestamp: Timestamp(), likes: 0, replyCount: 0)
        try await ThreadService.uploadThread(thread)
    }
}
