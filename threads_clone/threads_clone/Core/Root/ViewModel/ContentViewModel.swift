//
//  ContentViewModel.swift
//  threads_clone
//
//  Created by Mizuno Hikaru on 2024/01/24.
//

import Foundation
import Combine // 非同期プログラミングをサポート
import Firebase

class ContentViewModel: ObservableObject {
    
    // Firebaseのユーザー情報を保持
    @Published var userSession: FirebaseAuth.User?
    
    // 非同期タスクのキャンセルを管理
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscribers()
    }
    
    // userSessionプロパティの変更を監視
    private func setupSubscribers() {
        // $ : @Publishedのプロパティを監視し、変更があるたびに通知を送ることができます。この通知は、$をプロパティ名の前に付けることでアクセスできます
        AuthService.shared.$userSession.sink { [weak self] userSession in
            self?.userSession = userSession
        }.store(in: &cancellables) // 監視タスクをcancellablesセットに保存
    }
}

/// cancellablesセットに監視タスクを保存するメリット
/// 1. メモリリークの防止  :  cancellablesセットに保存することで、ContentViewModelインスタンスが解放されるときに、自動的に全ての購読がキャンセルされます。
/// 2. ライフサイクル管理  :  複数の購読を一箇所で管理できるため、それぞれの購読を個別にキャンセルする手間が省けます
/// ContentViewModelが不要になったときに、cancellablesに含まれる全ての購読を一括でキャンセルできます
/// 3. コードの整理  :  購読をキャンセルする責任が明確になり、コードが整理され、保守が容易になります
