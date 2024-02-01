//
//  LoginViewModel.swift
//  threads_clone
//
//  Created by Mizuno Hikaru on 2024/01/24.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    @MainActor
    func login() async throws {
        try await AuthService.shared.login(
            withEmail: email,
            password: password
        )
    }
}
