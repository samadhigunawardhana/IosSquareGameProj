//
//  RegisterView.swift
//  FurnitureApp
//
//  Created by Samadhi Gunawardhana on 2025-04-04.
//
import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var isPasswordVisible = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header
            Text("Create")
                .font(.system(size: 32, weight: .bold))
                .padding(.top, 60)
            
            Text("Account")
                .font(.system(size: 32, weight: .bold))
                .padding(.bottom, 32)
            
            // Form fields
            VStack(spacing: 16) {
                // Email
//                TextField("Email", text: $authViewModel.email)
//                    .padding()
//                    .background(Color(.systemGray6))
//                    .cornerRadius(8)
//                    .keyboardType(.emailAddress)
//                    .autocapitalization(.none)
                TextField("Email", text: $authViewModel.email)
                    //.keyboardType(.emailAddress)
                    //.autocapitalization(.none)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                
                // Password (with toggle visibility)
                HStack {
                    if isPasswordVisible {
                        TextField("Password", text: $authViewModel.password)
                    } else {
                        SecureField("Password", text: $authViewModel.password)
                    }
                    
                    Button {
                        isPasswordVisible.toggle()
                    } label: {
                        Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                
                // Full name
                TextField("Full name", text: $authViewModel.fullName)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
            }
            
            if !authViewModel.errorMessage.isEmpty {
                Text(authViewModel.errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
                    .padding(.top, 8)
            }
            
            Spacer()
            
            // Buttons
            VStack(spacing: 12) {
                Button {
                    authViewModel.createAccount()
                } label: {
                    Text("Done")
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                
                Button {
                    authViewModel.authState = .start
                } label: {
                    Text("Cancel")
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                }
            }
            .padding(.bottom, 40)
        }
        .padding()
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
            .environmentObject(AuthViewModel())
    }
}
