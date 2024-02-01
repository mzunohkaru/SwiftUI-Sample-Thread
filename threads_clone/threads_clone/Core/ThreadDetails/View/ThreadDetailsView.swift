//
//  ThreadDetailsView.swift
//  threads_clone
//
//  Created by Mizuno Hikaru on 2024/02/01.
//

import SwiftUI

struct ThreadDetailsView: View {
    
    let thread: Thread
    
    @StateObject var viewModel: ThreadDetailsViewModel
    
    init(thread: Thread) {
        self.thread = thread
        self._viewModel = StateObject(wrappedValue: ThreadDetailsViewModel(thread: thread))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    CircularProfileImageView(user: thread.user, size: .small)
                    
                    Text(thread.user?.username ?? "")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Text(thread.timestamp.timestampString())
                        .font(.caption)
                        .foregroundColor(Color(.systemGray3))
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "ellipsis")
                            .foregroundColor(Color(.darkGray))
                    }
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    Text(thread.caption)
                        .font(.subheadline)
                    
                    ContentActionButtonsView(thread: thread)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Divider()
                .padding(.vertical)
            
            LazyVStack {
                ForEach(viewModel.replies) { reply in
                    ThreadReplyCell(reply: reply)
                }
            }
        }
        .padding()
        .navigationTitle("Thread")
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct ThreadDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ThreadDetailsView(thread: dev.thread)
    }
}
