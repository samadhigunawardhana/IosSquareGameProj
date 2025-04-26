//
//  ARFurnitureAppApp.swift
//  ARFurnitureApp
//
//  Created by Samadhi Gunawardhana on 2025-04-16.
//

import SwiftUI

@main
struct ARFurnitureAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
