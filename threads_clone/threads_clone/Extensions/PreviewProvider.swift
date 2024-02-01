//
//  PreviewProvider.swift
//  threads_clone
//
//  Created by Mizuno Hikaru on 2024/01/24.
//

import SwiftUI
import Firebase

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.shared
    }
}

class DeveloperPreview {
    static let shared = DeveloperPreview()
    
    let user = User(id: NSUUID().uuidString, fullname: "田中 角栄", email: "tanaka@gmail.com", username: "角ちゃん")
    
    lazy var thread = Thread(
        ownerUid: "123",
        caption: "テスト投稿",
        timestamp: Timestamp(),
        likes: 3,
        replyCount: 5,
        user: user
    )
    
    lazy var reply = ThreadReply(
        threadId: "12345",
        replyText: "リプライです！",
        threadReplyOwnerUid: "123",
        threadOwnerUid: "5678",
        timestamp: Timestamp(),
        thread: thread,
        replyUser: user
    )
}
