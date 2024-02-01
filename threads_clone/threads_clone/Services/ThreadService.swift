//
//  ThreadService.swift
//  threads_clone
//
//  Created by Mizuno Hikaru on 2024/01/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct ThreadService {
    // *関数のパラメータ名に _ を使用すると、関数を呼び出す際にパラメータ名を省略できる
    static func uploadThread(_ thread: Thread) async throws {
        guard let threadData = try? Firestore.Encoder().encode(thread) else { return }
        // エンコードされたスレッドデータをFirestoreの"threads"コレクションに追加
        try await FirestoreConstants.ThreadsCollection.addDocument(data: threadData)
    }
    
    static func fetchThreads() async throws -> [Thread] {
        let snapshot = try await FirestoreConstants.ThreadsCollection
            .order(by: "timestamp", descending: true)
            .getDocuments()
        
        // 取得したドキュメントをスレッドオブジェクトにデコードし、その配列を返します
        return snapshot.documents.compactMap({ try? $0.data(as: Thread.self) })
    }
    
    static func fetchUserThreads(uid: String) async throws -> [Thread] {
        let snapshot = try await FirestoreConstants.ThreadsCollection
            // "ownerUid"フィールドが指定したユーザーIDと一致するドキュメントを取得
            .whereField("ownerUid", isEqualTo: uid)
            .getDocuments()

        // 取得したドキュメントをスレッドオブジェクトにデコード
        let threads = snapshot.documents.compactMap({ try? $0.data(as: Thread.self) })
        // スレッドをそのタイムスタンプに基づいて降順にソートし、その配列を返します
        return threads.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() })
    }
    
    static func fetchThreadReplies(forUser user: User) async throws -> [ThreadReply] {
        let snapshot = try await FirestoreConstants
            .RepliesCollection
            .whereField("threadReplyOwnerUid", isEqualTo: user.id)
            .getDocuments()
        
        var replies = snapshot.documents.compactMap({ try? $0.data(as: ThreadReply.self) })
        
        for i in 0 ..< replies.count {
            replies[i].replyUser = user
        }
        
        return replies
    }
    
    static func fetchThread(threadId: String) async throws -> Thread {
        let snapshot = try await FirestoreConstants
            .ThreadsCollection
            .document(threadId)
            .getDocument()
        
        return try snapshot.data(as: Thread.self)
    }
    
    static func fetchLikedThreadsByUser(uid: String) async throws -> [Thread] {
        let userLikesSnapshot = try await FirestoreConstants.UserCollection
            .document(uid)
            .collection("user-likes")
            .getDocuments()
        
        var likedThreads = [Thread]()
        for document in userLikesSnapshot.documents {
            let threadId = document.documentID
            var thread = try await fetchThread(threadId: threadId)
            thread.user = try await UserService.fetchUser(withUid: thread.ownerUid)
            likedThreads.append(thread)
        }
        
        return likedThreads
    }
}

// MARK: - Likes

extension ThreadService {
    static func likeThread(_ thread: Thread) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let threadRef = FirestoreConstants.ThreadsCollection.document(thread.id)
        let userRef = FirestoreConstants.UserCollection.document(uid)
        
        async let _ = try await threadRef
            .collection("thread-likes")
            .document(uid)
            .setData([:]) // Dictionary初期化
        async let _ = try await threadRef.updateData(["likes": thread.likes + 1])
        async let _ = try await userRef
            .collection("user-likes")
            .document(thread.id)
            .setData([:])
    }
    
    static func unlikeThread(_ thread: Thread) async throws {
        // threadの「いいね」が 0より大きい場合は、処理を続行。 0より小さい場合は、return
        guard thread.likes > 0 else { return }
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let threadRef = FirestoreConstants.ThreadsCollection.document(thread.id)
        let userRef = FirestoreConstants.UserCollection.document(uid)
        
        async let _ = try await threadRef
            .collection("thread-likes")
            .document(uid)
            .delete()
        async let _ = try await userRef
            .collection("user-likes")
            .document(thread.id)
            .delete()
        async let _ = try await threadRef.updateData(["likes": thread.likes - 1])
    }
    
    static func checkIfUserLikedThread(_ thread: Thread) async throws -> Bool {
        guard let uid = Auth.auth().currentUser?.uid else { return false }
        
        let snapshot = try await FirestoreConstants.UserCollection
            .document(uid)
            .collection("user-likes")
            .document(thread.id)
            .getDocument()
        
        // exists : Firestoreに存在する場合は、true
        return snapshot.exists
    }
}

/* 引数の _ について

func uploadThread(thread: Thread) { /*...*/ }
uploadThread(thread: someThread)

func uploadThread(_ thread: Thread) { /*...*/ }
uploadThread(someThread)

*/
