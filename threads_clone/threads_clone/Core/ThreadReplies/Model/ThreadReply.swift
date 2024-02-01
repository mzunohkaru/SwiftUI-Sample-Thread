//
//  ThreadReply.swift
//  threads_clone
//
//  Created by Mizuno Hikaru on 2024/02/01.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

struct ThreadReply: Identifiable, Codable {
    
    @DocumentID var replyId: String?
    let threadId: String
    let replyText: String
    let threadReplyOwnerUid: String
    let threadOwnerUid: String
    let timestamp: Timestamp
    
    var thread: Thread?
    var replyUser: User?
    
    var id: String {
        return replyId ?? NSUUID().uuidString
    }
}
