//
//  LoginView.swift
//  threads_clone
//
//  Created by Mizuno Hikaru on 2024/01/22.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Image("threads-app-icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100)
                
                VStack {
                    TextField("Enter your email", text: $viewModel.email)
                    // 先頭文字が大文字で入力されないようにする
                        .autocapitalization(.none)
                        .modifier(ThreadsTextFieldModifire())
                    
                    SecureField("Enter your password", text: $viewModel.password)
                        .modifier(ThreadsTextFieldModifire())
                }
                
                NavigationLink {
                    
                } label: {
                    Text("Forgot password")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.vertical)
                        .padding(.trailing, 28)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
                Button {
                    Task { try await viewModel.login() }
                } label: {
                    Text("Login")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 352, height: 44)
                        .background(.black)
                        .cornerRadius(8)
                }
                
                Spacer()
                
                Divider()
                
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3) {
                        Text("Do not have an account?")
                        
                        Text("Sign Up")
                            .fontWeight(.semibold)
                    }
                    .font(.footnote)
                    .foregroundColor(.blue)
                }
                .padding(.vertical, 16)
            }
        }
    }
}

#Preview {
    LoginView()
}
