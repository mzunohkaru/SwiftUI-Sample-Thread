//
//  RegistrationView.swift
//  threads_clone
//
//  Created by Mizuno Hikaru on 2024/01/22.
//

import SwiftUI

struct RegistrationView: View {
    
    @StateObject var viewModel = RegistrationViewModel()
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Spacer()
            
            Image("threads-app-icon")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            VStack {
                TextField("Enter your email", text: $viewModel.email)
                // 先頭文字が大文字で入力されないようにする
                    .autocapitalization(.none)
                    .modifier(ThreadsTextFieldModifire())
                
                SecureField("Enter your password", text: $viewModel.password)
                    .modifier(ThreadsTextFieldModifire())
                
                TextField("Enter your fullname", text: $viewModel.fullname)
                    .modifier(ThreadsTextFieldModifire())
                
                TextField("Enter your username", text: $viewModel.username)
                    .autocapitalization(.none)
                    .modifier(ThreadsTextFieldModifire())
            }
            
            Button {
                Task { try await viewModel.createUser() }
            } label: {
                Text("Sign Up")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 352, height: 44)
                    .background(.black)
                    .cornerRadius(8)
            }
            .padding(.vertical)
            
            Spacer()
            
            Divider()
            
            Button {
                dismiss()
            } label: {
                HStack(spacing: 3) {
                    Text("Already have an account?")
                    
                    Text("Sign In")
                        .fontWeight(.semibold)
                }
                .font(.footnote)
                .foregroundColor(.blue)
            }
            .padding(.vertical, 16)
        }
    }
}

#Preview {
    RegistrationView()
}
