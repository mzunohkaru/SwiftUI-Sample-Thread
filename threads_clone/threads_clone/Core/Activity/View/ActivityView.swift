//
//  ActivityView.swift
//  threads_clone
//
//  Created by Mizuno Hikaru on 2024/01/22.
//

import SwiftUI

struct ActivityView: View {
    
    @StateObject var viewModel = ActivityViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(viewModel.threadLiked) { thread in
                        ActivityCell(thread: thread)
                    }

                }
            }
            .refreshable {
                // スレッドデータをリロード
                Task { try await viewModel.fetchLikedThreadData() }
            }
            .navigationDestination(for: Thread.self, destination: { thread in
                ThreadDetailsView(thread: thread)
            })
            .navigationTitle("Favorite")
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
    ActivityView()
}
