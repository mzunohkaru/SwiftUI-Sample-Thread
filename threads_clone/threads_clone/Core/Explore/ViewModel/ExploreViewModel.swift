//
//  ExploreViewModel.swift
//  threads_clone
//
//  Created by Mizuno Hikaru on 2024/01/24.
//

import Foundation

class ExploreViewModel: ObservableObject {
    
    @Published var users = [User]()
    
    init() {
        Task { try await fetchUsers() }
    }
    
    // @MainActor: UIの更新をするため
    @MainActor
    private func fetchUsers() async throws {
        self.users = try await UserService.fetchUsers()
    }
}
