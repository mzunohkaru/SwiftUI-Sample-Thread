//
//  ThreadReplyViewModel.swift
//  threads_clone
//
//  Created by Mizuno Hikaru on 2024/02/01.
//

import Foundation
import Firebase
import FirebaseAuth

class ThreadReplyViewModel: ObservableObject {
    
    func uploadThreadReply(replyText: String, thread: Thread) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let reply = ThreadReply(
            threadId: thread.id,
            replyText: replyText,
            threadReplyOwnerUid: uid,
            threadOwnerUid: thread.ownerUid,
            timestamp: Timestamp()
        )
        
        try await ThreadReplyService.uploadThreadReply(reply, toThread: thread)
    }
}
