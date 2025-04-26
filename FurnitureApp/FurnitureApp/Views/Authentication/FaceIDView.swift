//
//  FaceIDView.swift
//  FurnitureApp
//
//  Created by Samadhi Gunawardhana on 2025-04-04.
//
import SwiftUI
//import UIKit
import LocalAuthentication


struct FaceIDView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            Text("Face ID")
                .font(.system(size: 28, weight: .bold))
                .padding(.bottom, 40)
            
            // Face ID icon
            Image(systemName: "faceid")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
                .padding(32)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(16)
                .padding(.bottom, 40)
            
            Spacer()
            
            // Buttons
            VStack(spacing: 12) {
                Button {
                    authViewModel.setupFaceID()
                } label: {
                    Text("Set Up")
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                
                Button {
                    authViewModel.skipFaceID()
                } label: {
                    Text("Skip")
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                        .padding(.vertical, 14)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 40)
        }
        .padding()
    }
}

struct FaceIDView_Previews: PreviewProvider {
    static var previews: some View {
        FaceIDView()
            .environmentObject(AuthViewModel())
    }
}
