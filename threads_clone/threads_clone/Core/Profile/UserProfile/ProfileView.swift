//
//  ProfileView.swift
//  threads_clone
//
//  Created by Mizuno Hikaru on 2024/01/22.
//

import SwiftUI

struct ProfileView: View {
    
    let user: User
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            // bio and stats
            VStack(spacing: 20) {
                ProfileHeaderView(user: user)
                
                Button {
                    
                } label: {
                    Text("Follow")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 352, height: 32)
                        .background(.black)
                        .cornerRadius(8)
                }
                
                //user content list view
                
                UserContentListView(user: user)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal)
    }
}

//#Preview {
//    ProfileView(user: dev.user)
//}
