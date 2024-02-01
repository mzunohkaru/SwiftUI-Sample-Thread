//
//  Constants.swift
//  threads_clone
//
//  Created by Mizuno Hikaru on 2024/02/01.
//

import Foundation
import FirebaseFirestore

struct FirestoreConstants {
    private static let Root = Firestore.firestore()
    
    static let UserCollection = Root.collection("users")
    
    static let ThreadsCollection = Root.collection("threads")
    
    static let FollowersCollection = Root.collection("followers")
    static let FolloweingCollection = Root.collection("following")
    
    static let RepliesCollection = Root.collection("replies")
    
    static let ActivityCollection = Root.collection("avtivity")
}
