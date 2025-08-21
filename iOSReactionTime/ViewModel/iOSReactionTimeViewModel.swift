//
//  iOSReactionTimeViewModel.swift
//  iOSReactionTime
//
//  Created by Yosup Cheon on 2025-08-20.
//

import SwiftUI

// ViewModel to handle game logic
class ReactionViewModel: ObservableObject {
    @Published var gameStarted = false
    @Published var colorChanged = false
    @Published var message = "Tap Start to Begin"
    @Published var reactionTime: Double? = nil
    @Published var bestTime: Double? = UserDefaults.standard.double(forKey: "BestTime").isZero ? nil : UserDefaults.standard.double(forKey: "BestTime")
    
    private var startTime: Date?
    
    func startGame() {
        gameStarted = true
        colorChanged = false
        message = "Wait for green..."
        reactionTime = nil
        
        // Random delay before changing color
        let delay = Double.random(in: 1.5...3.0)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.colorChanged = true
            self.message = "Tap now!"
            self.startTime = Date()
        }
    }
    
    func stopGame() {
        guard gameStarted else { return }
        
        if colorChanged, let start = startTime {
            let time = Date().timeIntervalSince(start)
            reactionTime = time
            message = String(format: "Your time: %.3f seconds", time)
            
            // Update best score if needed
            if let best = bestTime {
                if time < best {
                    bestTime = time
                    UserDefaults.standard.set(time, forKey: "BestTime")
                    message += " (New Best!)"
                }
            } else {
                bestTime = time
                UserDefaults.standard.set(time, forKey: "BestTime")
                message += " (New Best!)"
            }
            
        } else {
            message = "Too early! Try again."
        }
        
        gameStarted = false
        colorChanged = false
    }
}
