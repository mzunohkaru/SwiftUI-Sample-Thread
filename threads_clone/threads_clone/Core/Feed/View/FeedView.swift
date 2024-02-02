//
//  FeedView.swift
//  threads_clone
//
//  Created by Mizuno Hikaru on 2024/01/22.
//

import SwiftUI

struct FeedView: View {
    
    @StateObject var viewModel = FeedViewModel()

    // FeedView と ThreadDetailsView と ContentActionButtonsView の viewModelの生成方法の違い

    // @StateObject var viewModel = FeedViewModel()
    // FeedViewModelは、アプリ起動時に一度だけ生成し、アプリ終了時まで破棄しないため、
    // アプリのライフサイクルと密接に関係している

    // @StateObject var viewModel: ThreadDetailsViewModel
    // ThreadDetailsViewModelは、それぞれのスレッドの詳細ページで生成する必要があるため、
    // Viewのライフサイクルと密接に関係している

    // @ObservedObject var viewModel: ContentActionButtonsViewModel
    // ContentActionButtonsViewModelは、外部からビュー (ContentActionButtonView)に渡されるViewModelを参照するため、
    // ViewModelの変更のみを監視するもので、ライフサイクルの管理をしない
    
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
