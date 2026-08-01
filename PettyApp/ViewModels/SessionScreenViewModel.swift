//
//  SessionScreenViewModel.swift
//  PettyApp
//
//  Created by Viktoriia Savchuk  on 31/07/2026.
//


import SwiftUI

@Observable
class SessionScreenViewModel {
    
    var secondsRemaining = 0
    var progress: Double = 0
    var progressStep: Double = 0
    var timer: Timer?
    var isRunning = false
    
    var isFinished = false
    
    var hour = 1
    var minutes = 30
    var seconds = 60
    
    var timeString: String {
        let hours = secondsRemaining / 3600
        let minutes = (secondsRemaining % 3600) / 60
        let seconds = secondsRemaining % 60

        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    func startTimer() {
        
        secondsRemaining = hour * 3600 + minutes * 60
        
        progressStep = 1 / Double(secondsRemaining)

        isRunning = true

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in

            if self.secondsRemaining > 0 {
                self.secondsRemaining -= 1
                self.progress += self.progressStep
            } else {
                self.timer?.invalidate()
                self.isRunning = false
                self.isFinished = true 
            }
        }
    }

}
