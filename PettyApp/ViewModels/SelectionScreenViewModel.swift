//
//  SelectionScreenViewModel.swift
//  PettyApp
//
//  Created by Viktoriia Savchuk  on 31/07/2026.
//

import SwiftUI

@Observable
class SelectionScreenViewModel {
    
    var breakTime = 5
    
    func minusButtonClicked() {
        if breakTime > 0 {
            breakTime -= 1
        } else {
            //notification
        }
    }
    
    func plusButtonClicked() {
        if breakTime < 31 {
            breakTime += 1
        } else {
            //notification
        }
    }
}
