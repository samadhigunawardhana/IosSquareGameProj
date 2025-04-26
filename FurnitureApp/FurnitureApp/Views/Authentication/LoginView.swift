//
//  LoginView.swift
//  FurnitureApp
//
//  Created by Samadhi Gunawardhana on 2025-04-04.
//
import SwiftUI
//import UIKit

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            // Background shapes
            VStack {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 300, height: 300)
                    .offset(x: 150, y: -150)
                
                Spacer()
            }
            
            VStack {
                Spacer()
                
                Circle()
                    .fill(Color.blue.opacity(0.3))
                    .frame(width: 200, height: 200)
                    .offset(x: -150, y: 0)
            }
            
            // Content
            VStack(alignment: .leading, spacing: 0) {
                // Header
                Text("Login")
                    .font(.system(size: 32, weight: .bold))
                    .padding(.top, 60)
                    .padding(.bottom, 4)
                
                Text("Good to see you back!")
                    .foregroundColor(.secondary)
                    .padding(.bottom, 32)
                
                // Email field
                TextField("Email", text: $authViewModel.email)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    //.keyboardType(UIKeyboardType.emailAddress)
                    //.textInputAutocapitalization(TextInputAutocapitalization.never)
                    .shadow(color: Color.black.opacity(0.05), radius: 5)
                
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
                        authViewModel.login()
                    } label: {
                        Text("Next")
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    
                    Button {
                        authViewModel.login()
                    } label: {
                        Text("Set Up Face ID")
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
        .edgesIgnoringSafeArea(.all)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthViewModel())
    }
}
