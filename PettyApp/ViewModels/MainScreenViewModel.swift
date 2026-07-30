//
//  MainScreenViewModel.swift
//  PettyApp
//
//  Created by Viktoriia Savchuk  on 30/07/2026.
//

import SwiftUI

@Observable
class MainScreenViewModel {
    var totalFocuseTime: TimeInterval = 0
    var totalFocusedHours: String = "*"
    var totalFocusedMinutes: String = "*"
    
    var isLoading = false
    
    func updateTotalFocusedTime(with time: TimeInterval) {
        totalFocuseTime += time
        totalFocusedHours = String("\(Int(totalFocuseTime / 3600))h")
        totalFocusedMinutes = String("\(Int(totalFocuseTime.truncatingRemainder(dividingBy: 3600) / 60))m")
    }
    
    func startInitialUpdate() async {
        isLoading = true
        try? await Task.sleep(for: .seconds(1))
        updateTotalFocusedTime(with: 10000)
        isLoading = false
    }
}
