//
//  ContentActionButtonsView.swift
//  threads_clone
//
//  Created by Mizuno Hikaru on 2024/02/01.
//

import SwiftUI

struct ContentActionButtonsView: View {
    
    @ObservedObject var viewModel: ContentActionButtonsViewModel
    @State private var showReplySheet = false
    
    init(thread: Thread) {
        self.viewModel = ContentActionButtonsViewModel(thread: thread)
    }
    
    private var didLike: Bool {
        return viewModel.thread.didLike ?? false
    }
    
    private var thread: Thread {
        return viewModel.thread
    }
    
    func handleLikeTapped() {
        Task {
            if didLike {
                try await viewModel.unlikeThread()
            } else {
                try await viewModel.likeThread()
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 16) {
                Button {
                    handleLikeTapped()
                } label: {
                    Image(systemName: didLike ? "heart.fill" : "heart")
                        .foregroundColor(didLike ? .red : .black)
                }
                
                Button {
                    showReplySheet.toggle()
                } label: {
                    Image(systemName: "bubble.right")
                }
                
                Button {
                    
                } label: {
                    Image(systemName: "arrow.rectanglepath")
                }
                
                Button {
                    
                } label: {
                    Image(systemName: "paperplane")
                }
            }
            
            HStack(spacing: 4) {
                if thread.replyCount > 0 {
                    Text("\(thread.replyCount) replies")
                }
                
                if thread.replyCount > 0 && thread.likes > 0 {
                    Text("-")
                }
                
                if thread.likes > 0 {
                    Text("\(thread.likes) likes")
                }
            }
            .font(.caption)
            .foregroundColor(.gray)
            .padding(.vertical, 4)
        }
        .sheet(isPresented: $showReplySheet) {
            ThreadReplyView(thread: thread)
        }
    }
}

struct ContentActionButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentActionButtonsView(thread: dev.thread)
    }
}

/*
@StateObject var viewModel: ThreadDetailsViewModel

init(thread: Thread) {
    self.thread = thread
    self._viewModel = StateObject(wrappedValue: ThreadDetailsViewModel(thread: thread))
}

・ @StateObjectは、プロパティが初期化されるときに一度だけオブジェクトを作成します
・ このプロパティラッパーは、そのそのビューが所有する状態を管理するために使用されます
・ ビューがその状態を所有している場合、またはそのビューがそのオブジェクトの唯一の所有者である場合に使用します
・ ビューが再描画されても、@StateObjectによって保持されるオブジェクトは破棄されず、同じインスタンスが保持され続けます

ユースケース : ビューが表示されるときにビューモデルを初期化し、ビューが破棄されるまでその状態を保持したい場合
*/

/*
@ObservedObject var viewModel: ContentActionButtonsViewModel

init(thread: Thread) {
    self.viewModel = ContentActionButtonsViewModel(thread: thread)
}

・ @ObservedObjectは、外部から渡されるオブジェクトを参照するために使用されます
・ このプロパティラッパーは、ビューが所有していないが、変更を監視する必要があるオブジェクトに使用されます
・ ビューの外部で作成され、ビューに渡されるオブジェクトを参照する場合に使用します
・ ビューが再描画されると、@ObservedObjectが参照するオブジェクトは変わらない可能性がありますが、オブジェクトの所有権はビューにはありません

ユースケース : 親ビューから子ビューにビューモデルを渡す場合や、複数のビュー間で共有されるビューモデルを参照する場合に使用します
*/