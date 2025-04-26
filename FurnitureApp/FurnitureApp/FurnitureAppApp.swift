//
//  FurnitureAppApp.swift
//  FurnitureApp
//
//  Created by Samadhi Gunawardhana on 2025-04-01.
//

import SwiftUI

@main
struct FurnitureAppApp: App {
    @StateObject var authViewModel = AuthViewModel()

    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(authViewModel)
        }
    }
}
