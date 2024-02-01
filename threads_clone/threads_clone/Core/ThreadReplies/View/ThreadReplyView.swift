//
//  ThreadReplyView.swift
//  threads_clone
//
//  Created by Mizuno Hikaru on 2024/02/01.
//

import SwiftUI

struct ThreadReplyView: View {
    
    let thread: Thread
    
    @State private var replyText = ""
    @State private var threadViewHeight: CGFloat = 24
    
    @StateObject var viewModel = ThreadReplyViewModel()
    
    @Environment(\.dismiss) var dismiss
    
    private var currentUser: User? {
        return UserService.shared.currentUser
    }
    
    func setThreadViewHeight() {
        // プロフィール画像のサイズをCGFloat型で定義
        let imageDimension: CGFloat = ProfileImageSize.small.dimension
        let padding: CGFloat = 16
        // UIScreen.main.bounds.width : 画面の幅
        let width = UIScreen.main.bounds.width - imageDimension - padding
        let font = UIFont.systemFont(ofSize: 12)
        
        // 指定された幅とフォントでテキストの高さを計算
        let captionSize = thread.caption.heightWithConstrainedWidth(width, font: font)
        
        threadViewHeight = captionSize + imageDimension - 16
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Divider()
                
                VStack(alignment: .leading, spacing: 12) {
                    HStack(alignment: .top) {
                        VStack {
                            CircularProfileImageView(user: thread.user, size: .small)
                            
                            Rectangle()
                                .frame(width: 2, height: threadViewHeight)
                                .foregroundColor(Color(.systemGray4))
                        }
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(thread.user?.username ?? "")
                                .fontWeight(.semibold)
                            
                            Text(thread.caption)
                                .multilineTextAlignment(.leading)
                        }
                        .font(.footnote)
                        
                        Spacer()
                    }
                    
                    HStack(alignment: .top) {
                        CircularProfileImageView(user: currentUser, size: .small)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(currentUser?.username ?? "")
                                .fontWeight(.semibold)
                            
                            TextField("Add your reply...", text: $replyText, axis: .vertical)
                                .multilineTextAlignment(.leading)
                        }
                        .font(.footnote)
                    }
                }
                .padding()
                
                Spacer()
            }
            .onAppear { setThreadViewHeight() }
            .navigationTitle("Reply")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .font(.subheadline)
                    .foregroundColor(.black)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Post") {
                        Task {
                            try await viewModel.uploadThreadReply(replyText: replyText, thread: thread)
                            dismiss()
                        }
                    }
                    .opacity(replyText.isEmpty ? 0.5 : 1.0)
                    // caption が空欄の場合は、ボタンとして機能しない
                    .disabled(replyText.isEmpty)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                }
            }
        }
    }
}


struct ThreadReplyView_Preview: PreviewProvider {
    static var previews: some View {
        ThreadReplyView(thread: dev.thread)
    }
}
