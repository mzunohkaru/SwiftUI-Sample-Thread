//
//  ActivityViewModel.swift
//  threads_clone
//
//  Created by Mizuno Hikaru on 2024/02/01.
//

import Foundation
import FirebaseAuth

class ActivityViewModel: ObservableObject {
    
    @Published var threadLiked = [Thread]()
    
    init() {
        Task { try await fetchLikedThreadData() }
    }
    
    @MainActor
    func fetchLikedThreadData() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        self.threadLiked = try await ThreadService.fetchLikedThreadsByUser(uid: uid)
    }
}
