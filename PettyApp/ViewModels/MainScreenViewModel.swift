//
//  MainScreenViewModel.swift
//  PettyApp
//
//  Created by Viktoriia Savchuk  on 30/07/2026.
//

import SwiftUI

@Observable
class MainScreenViewModel {
    
    private var totalFocusTime = 0
    var streak = 0
    private let defaults = UserDefaults.standard
    
    init() {
        totalFocusTime = defaults.integer(forKey: "totalFocusTime")
        checkNewWeek()
        checkStreak()
    }

    var totalFocusedHours: String = "0h"
    var totalFocusedMinutes: String = "0m"
    
    var isLoading = false
    
    func updateTotalFocusedTime(time: Int = 0) {
        if time > 0 {
            totalFocusTime += time
            defaults.set(totalFocusTime, forKey: "totalFocusTime")
        }
        
        if totalFocusTime != 0 {
            let hours = totalFocusTime / 3600
            let minutes = (totalFocusTime - hours * 3600) / 60
            totalFocusedHours = "\(hours)h"
            totalFocusedMinutes = "\(minutes)m"
        }
    }
    
    func startInitialUpdate() async {
        isLoading = true
        try? await Task.sleep(for: .seconds(1))
        updateTotalFocusedTime()
        checkStreak()
        isLoading = false
    }
    
    private func checkNewWeek() {
        let calendar = Calendar.current
        let today = Date()
     
        if let savedDate = defaults.object(forKey: "weekStartDate") as? Date {

            if !calendar.isDate(
                savedDate,
                equalTo: today,
                toGranularity: .weekOfYear
            ) {
                totalFocusTime = 0
                defaults.set(0, forKey: "totalFocusTime")
                defaults.set(today, forKey: "weekStartDate")
            }

        } else {
            //first time the app is opened
            defaults.set(today, forKey: "weekStartDate")
        }
    }
    
    private func checkStreak() {
        let calendar = Calendar.current
        let today = Date()

        guard let lastDate = defaults.object(forKey: "lastStreakDate") as? Date else {
            streak = 1
            defaults.set(streak, forKey: "currentStreak")
            defaults.set(today, forKey: "lastStreakDate")
            return
        }

        if calendar.isDate(lastDate, inSameDayAs: today) {
            streak = defaults.integer(forKey: "currentStreak")
            
        } else if let yesterday = calendar.date(byAdding: .day, value: -1, to: today),
                  calendar.isDate(lastDate, inSameDayAs: yesterday) {
            streak = defaults.integer(forKey: "currentStreak") + 1
            defaults.set(streak, forKey: "currentStreak")
            defaults.set(today, forKey: "lastStreakDate")
            
        } else {
            streak = 1
            defaults.set(streak, forKey: "currentStreak")
            defaults.set(today, forKey: "lastStreakDate")
        }
    }
}
