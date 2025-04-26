//
//  AuthViewModel.swift
//  FurnitureApp
//
//  Created by Samadhi Gunawardhana on 2025-04-04.
//
//import SwiftUI
import Foundation
import Combine

class AuthViewModel: ObservableObject {
    enum AuthState {
        case start
        case createAccount
        case login
        case faceID
        case authenticated
    }
    
    @Published var authState: AuthState = .start
    @Published var currentUser: User?
    @Published var email = ""
    @Published var password = ""
    @Published var fullName = ""
    @Published var errorMessage = ""
    
    // In a real app, these would connect to your AuthManager
    func createAccount() {
        guard !email.isEmpty, !password.isEmpty, !fullName.isEmpty else {
            errorMessage = "Please fill in all fields"
            return
        }
        
        // Create user and move to login screen
        let newUser = User(email: email, fullName: fullName)
        currentUser = newUser
        authState = .login
        errorMessage = ""
    }
    
    func login() {
        guard !email.isEmpty else {
            errorMessage = "Please enter your email"
            return
        }
        
        // For demo purposes - In a real app, validate credentials
        authState = .faceID
        errorMessage = ""
    }
    
    func setupFaceID() {
        // In a real app, this would use LocalAuthentication framework
        if let user = currentUser {
            currentUser = User(id: user.id, email: user.email, fullName: user.fullName, hasSetupFaceID: true)
        }
        authState = .authenticated
    }
    
    func skipFaceID() {
        authState = .authenticated
    }
    
    func signOut() {
        currentUser = nil
        authState = .start
        email = ""
        password = ""
        fullName = ""
    }
}
