//
//  FeedView.swift
//  threads_clone
//
//  Created by Mizuno Hikaru on 2024/01/22.
//

import SwiftUI

struct FeedView: View {
    
    @StateObject var viewModel = FeedViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                // 画面に表示しているコンポーネントのみ描画
                LazyVStack {
                    ForEach(viewModel.threads) { thread in
                        NavigationLink(value: thread) {
                            ThreadCell(thread: thread)
                        }
                    }
                }
            }
            .refreshable {
                // スレッドデータをリロード
                Task { try await viewModel.fetchThreads() }
            }
            .navigationDestination(for: Thread.self, destination: { thread in
                ThreadDetailsView(thread: thread)
            })
            .navigationTitle("Threads")
            .navigationBarTitleDisplayMode(.inline)
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                        .foregroundColor(.black)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        FeedView()
    }
}
