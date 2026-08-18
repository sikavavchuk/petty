//
//  SessionScreenViewModel.swift
//  PettyApp
//
//  Created by Viktoriia Savchuk  on 31/07/2026.
//


import SwiftUI

@Observable
class SessionScreenViewModel {
    
    //seperate timers for focus and pause
    //same with flags
    //make main timer stop
    
    var secondsRemaining = 0
    var progress: Double = 0
    private var timer: Timer?
    
    var isRunning = false
    var isFinished = false
    
    var totalTimerSeconds: Int = 0
    
    var timeString: String {
        let hours = secondsRemaining / 3600
        let minutes = (secondsRemaining % 3600) / 60
        let seconds = secondsRemaining % 60

        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    func isTimerRunning() {
        if isRunning {
            isRunning = false
        } else {
            isRunning = true
        }
    }
    
    func isTimerFinished() {
        if isFinished {
            isFinished = false
        } else {
            isFinished = true
        }
    }
    
    func startTimer() {
        secondsRemaining = totalTimerSeconds

        print("SessionSV: \(secondsRemaining)")

        isTimerRunning()

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in

            if self.secondsRemaining > 0 {
                self.secondsRemaining -= 10 // speeding up for testing
                self.progress =
                    1 - (Double(self.secondsRemaining) / Double(self.totalTimerSeconds))
            } else {
                self.secondsRemaining = 0
                self.progress = 1

                self.timer?.invalidate()
                self.timer = nil

                self.isTimerRunning()
                self.isTimerFinished()
            }
        }
    }

}
