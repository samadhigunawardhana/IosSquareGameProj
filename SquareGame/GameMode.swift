//
//  GameMode.swift
//  SquareGame
//
//  Created by Samadhi Gunawardhana on 2025-02-01.
//
import Foundation
enum GameMode {
    case easy
    case medium
    case hard
    
    var timeLimit: TimeInterval {
        switch self {
        case .easy: return 120    // 2 minutes
        case .medium: return 60   // 1 minute
        case .hard: return 30     // 30 seconds
        }
    }
    
    var description: String {
        switch self {
        case .easy: return "Easy Mode"
        case .medium: return "Medium Mode"
        case .hard: return "Hard Mode"
        }
    }
}
