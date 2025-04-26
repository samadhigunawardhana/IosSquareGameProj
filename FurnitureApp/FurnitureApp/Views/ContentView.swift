//
//  ContentView.swift
//  FurnitureApp
//
//  Created by Samadhi Gunawardhana on 2025-04-04.
//
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        Group {
            switch authViewModel.authState {
            case .start:
                StartView()
            case .createAccount:
                RegisterView()
            case .login:
                LoginView()
            case .faceID:
                FaceIDView()
            case .authenticated:
                // This would be your main app view
                Text("Welcome to Furnish App!")
                    .font(.largeTitle)
                    .bold()
            }
        }
    }
}
