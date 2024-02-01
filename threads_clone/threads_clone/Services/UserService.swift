//
//  UserService.swift
//  threads_clone
//
//  Created by Mizuno Hikaru on 2024/01/24.
//

import Firebase
import FirebaseFirestoreSwift

class UserService {
    
    @Published var currentUser: User?
    
    /// シングルトンインスタンスを作成
    /// インスタンスの共有 : アプリ全体で共有される唯一のUserServiceインスタンスを提供
    /// 異なる部分のコードから同じインスタンスにアクセスできます
    /// リソースの効率的な使用 : 必要なリソースを一度だけ確保し、それを再利用するため、メモリとCPUの使用を最小限に抑えます
    static let shared = UserService()
    
    init() {
        Task { try await fetchCurrentUser() }
    }
    
    @MainActor
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        // FireStoreからデータを取得
        let snapshot = try await FirestoreConstants.UserCollection.document(uid).getDocument()
        // スナップショットのデータをUser型にデコード（変換)
        // User.self : User型自体を参照
        let user = try snapshot.data(as: User.self)
        self.currentUser = user
    }
    
    static func fetchUsers() async throws -> [User] {
        // 現在のユーザーの uid を取得
        guard let curretnUid = Auth.auth().currentUser?.uid else { return [] }
        // FireStoreのusersに保存された全ユーザーのデータを取得
        let snapshot = try await FirestoreConstants.UserCollection.getDocuments()
        // compactMap : 配列の各要素に対して変換を試み、その結果がnilでない場合にのみ新しい配列に含める
        // try? $0.data(as: User.self) : 各ドキュメントをUser型にデコード（変換）
        let users = snapshot.documents.compactMap({ try? $0.data(as: User.self) })
        // 現在のユーザー以外のユーザーデータを [User] に格納する
        return users.filter({
            $0.id != curretnUid
        })
    }
    
    static func fetchUser(withUid uid: String) async throws -> User {
        let snapshot = try await FirestoreConstants.UserCollection.document(uid).getDocument()
        // Firestoreから取得したデータをUser型にデコード（変換）する
        // User.self : User型自体を参照
        return try snapshot.data(as: User.self)

        // Firestoreから取得したデータは、非構造化の形（辞書型）で取得されます。
        // しかし、Swiftでは、この非構造化データを扱いやすい形（この場合はUser型）に変換する必要がある
    }
    
    func reset() {
        self.currentUser = nil
    }
    
    @MainActor
    func updateUserProfileImage(withImageUrl imageUrl: String) async throws {
        guard let curretnUid = Auth.auth().currentUser?.uid else { return }
        // Firebase Store のデータをアップデート
        try await FirestoreConstants.UserCollection.document(curretnUid).updateData([
            "profileImageUrl": imageUrl
        ])
        self.currentUser?.profileImageUrl = imageUrl
    }
}
