//
//  UserCell.swift
//  threads_clone
//
//  Created by Mizuno Hikaru on 2024/01/22.
//

import SwiftUI

struct UserCell: View {
    
    let user: User
    
    var body: some View {
        HStack {
            CircularProfileImageView(user: user, size: .small)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(user.username)
                    .fontWeight(.semibold)
                
                Text(user.fullname)
            }
            .font(.footnote)
            
            
            Spacer()
            
            Text("Follow")
                .font(.subheadline)
                .fontWeight(.semibold)
                .frame(width: 100, height: 32)
            // OutLine
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                }
        }
        .padding(.horizontal)
    }
}

//#Preview {
//    UserCell(user: dev.user)
//}
