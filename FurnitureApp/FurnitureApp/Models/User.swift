//
//  User.swift
//  FurnitureApp
//
//  Created by Samadhi Gunawardhana on 2025-04-04.
//
import Foundation

struct User: Codable, Identifiable {
    var id: String
    var email: String
    var fullName: String
    var hasSetupFaceID: Bool
    
    init(id: String = UUID().uuidString, email: String, fullName: String, hasSetupFaceID: Bool = false) {
        self.id = id
        self.email = email
        self.fullName = fullName
        self.hasSetupFaceID = hasSetupFaceID
    }
}
