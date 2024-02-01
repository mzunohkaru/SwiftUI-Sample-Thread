//
//  Thread.swift
//  threads_clone
//
//  Created by Mizuno Hikaru on 2024/01/24.
//

import Firebase
import FirebaseFirestoreSwift

struct Thread: Identifiable, Hashable, Codable {
    /// FirestoreのドキュメントIDを自動的にマッピングする
    /// 自動マッピング : @DocumentIDを使用すると、Firestoreから取得したデータをSwiftのモデルに自動的にマッピングする際に、このドキュメントIDを直接モデルのプロパティに割り当てることができます
    /// 便利なアクセス : @DocumentIDを使用すると、ドキュメントIDに直接アクセスでき、データベース内の特定のドキュメントを簡単に参照できます
    @DocumentID var threadId: String?
    let ownerUid: String
    let caption: String
    let timestamp: Timestamp
    var likes: Int
    var replyCount: Int
    
    var didLike: Bool? = false
    
    var id: String {
        // Firestoreから取得したスレッドのドキュメントIDを直接ThreadモデルのthreadIdプロパティに割り当てる
        return threadId ?? NSUUID().uuidString
    }
    
    var user: User?
}
