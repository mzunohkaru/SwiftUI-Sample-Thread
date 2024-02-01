//
//  ThreadCell.swift
//  threads_clone
//
//  Created by Mizuno Hikaru on 2024/01/22.
//

import SwiftUI

struct ThreadCell: View {
    
    let thread: Thread
    
    var body: some View {
        VStack {
            HStack {
                CircularProfileImageView(user: thread.user, size: .small)
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
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
                    
                    Text(thread.caption)
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                    
                    ContentActionButtonsView(thread: thread)
                        .foregroundColor(.black)
                        .padding(.vertical, 8)
                }
            }
            
            Divider()
            
        }
        .padding()
    }
}

#Preview {
    ThreadCell(thread: DeveloperPreview.shared.thread)
}
