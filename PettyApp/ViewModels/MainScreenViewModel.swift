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
    private let defaults = UserDefaults.standard
    
    init() {
        totalFocusTime = defaults.integer(forKey: "totalFocusTime")
        checkNewWeek()
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
}
