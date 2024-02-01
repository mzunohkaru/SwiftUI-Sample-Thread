//
//  CurrentUserProfileView.swift
//  threads_clone
//
//  Created by Mizuno Hikaru on 2024/01/24.
//

import SwiftUI

struct CurrentUserProfileView: View {
    
    @StateObject var viewModel = CurrentUserProfileViewModel()
    
    @State private var showEditProfile = false
    
    private var currentUser: User? {
        return viewModel.currentUser
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                // bio and stats
                VStack(spacing: 20) {
                    
                    ProfileHeaderView(user: currentUser)
                    
                    HStack {
                        Button {
                            showEditProfile.toggle()
                        } label: {
                            Text("Edit Profile")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                                .frame(width: 170, height: 32)
                                .background(.white)
                                .cornerRadius(8)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(.systemGray4), lineWidth: 1)
                                }
                        }
                        
                        Button {
                            
                        } label: {
                            Text("Share Profile")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                                .frame(width: 170, height: 32)
                                .background(.white)
                                .cornerRadius(8)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(.systemGray4), lineWidth: 1)
                                }
                        }
                    }
                    
                    //user content list view
                    
                    if let user = currentUser {
                        UserContentListView(user: user)
                    }
                }
            }
            .sheet(isPresented: $showEditProfile, content: {
                if let user = currentUser {
                    EditProfileView(user: user)
                }
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        AuthService.shared.signOut()
                    } label: {
                        Image(systemName: "line.3.horizontal")
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    CurrentUserProfileView()
}
