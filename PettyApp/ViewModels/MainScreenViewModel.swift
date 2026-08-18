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
    var totalFocusedHours: String = "0h"
    var totalFocusedMinutes: String = "0m"
    
    var isLoading = false
    
    func updateTotalFocusedTime(time: Int = 0) {
        //logic isolation
        if time > 0 {
            totalFocusTime += time
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
}
