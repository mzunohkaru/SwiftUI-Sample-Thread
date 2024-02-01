//
//  ProfileThreadFilter.swift
//  threads_clone
//
//  Created by Mizuno Hikaru on 2024/01/23.
//

import Foundation

enum ProfileThreadFilter: Int, CaseIterable, Identifiable {
    case threads
    case replies
//    case likes
    
    var title: String {
        switch self {
        case .threads: return "Threads"
        case .replies: return "Replies"
//        case .likes: return "Likes"
        }
    }
    
    var id: Int { return self.rawValue }
}
