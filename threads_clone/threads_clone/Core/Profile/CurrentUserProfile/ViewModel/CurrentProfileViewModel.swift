//
//  ProfileViewModel.swift
//  threads_clone
//
//  Created by Mizuno Hikaru on 2024/01/24.
//

import Foundation
import Combine
import PhotosUI
import SwiftUI

class CurrentUserProfileViewModel: ObservableObject {
    
    @Published var currentUser: User?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscribers()
    }
    
    //    private func setupSubscribers() {
    //        UserService.shared.$currentUser.sink { [weak self] user in
    //            self?.currentUser = user
    //        }.store(in: &cancellables)
    //    }
    
    private func setupSubscribers() {
        UserService.shared.$currentUser
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
                self?.currentUser = user
            }
            .store(in: &cancellables)
    }
    
    
}
