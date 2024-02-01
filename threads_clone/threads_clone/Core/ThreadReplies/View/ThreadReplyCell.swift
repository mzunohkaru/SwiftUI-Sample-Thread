//
//  ThreadReplyCell.swift
//  threads_clone
//
//  Created by Mizuno Hikaru on 2024/02/01.
//

import SwiftUI

struct ThreadReplyCell: View {
    
    let reply: ThreadReply
    
    private var user: User? {
        return reply.replyUser
    }
    
    var body: some View {
        VStack {
            HStack {
                CircularProfileImageView(user: user, size: .small)
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(user?.username ?? "")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Text(reply.timestamp.timestampString())
                            .font(.caption)
                            .foregroundColor(Color(.systemGray3))
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundColor(Color(.darkGray))
                        }
                    }
                    
                    Text(reply.replyText)
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                }
            }
            
            Divider()
            
        }
        .padding()
    }
}


struct ThreadReplyCell_Previews: PreviewProvider {
    static var previews: some View {
        ThreadReplyCell(reply: dev.reply)
    }
}
