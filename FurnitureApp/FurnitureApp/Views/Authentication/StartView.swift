//
//  StartView.swift
//  FurnitureApp
//
//  Created by Samadhi Gunawardhana on 2025-04-04.
//
import SwiftUI

struct StartView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            // App icon
            Image(systemName: "bag.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60)
                .foregroundColor(.blue)
                .padding(.bottom, 16)
            
            // App name
            Text("Furnish")
                .font(.system(size: 34, weight: .bold))
                .padding(.bottom, 8)
            
            // Tagline
            Text("Smart Living - Augmented")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text("Experience Furniture Like")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text("Never Before")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.bottom, 32)
            
            Spacer()
            
            // Get Started Button
            Button {
                authViewModel.authState = .createAccount
            } label: {
                Text("Let's get started")
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .padding(.horizontal, 16)
            }
            .padding(.bottom, 12)
            
            // Already have account section
            HStack(spacing: 4) {
                Text("I already have an account")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                
                Button {
                    authViewModel.authState = .login
                } label: {
                    HStack(spacing: 0) {
                        Image(systemName: "circle.fill")
                            .font(.system(size: 5))
                            .foregroundColor(.blue)
                            .padding(.trailing, 4)
                        
                        Text("Login")
                            .font(.footnote)
                            .foregroundColor(.blue)
                            .fontWeight(.semibold)
                    }
                }
            }
            .padding(.bottom, 40)
        }
        .padding()
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
            .environmentObject(AuthViewModel())
    }
}
