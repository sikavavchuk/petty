import SwiftUI

@Observable
class SessionScreenViewModel {
    
    // MARK: - Focus
    
    var focusSecondsRemaining = 0
    var focusProgress: Double = 0
    private var focusTimer: Timer?
    
    var focusTimerRunning = false
    var focusTimerFinished = false
    
    var totalFocusTimerSeconds: Int = 0
    
    var focusTimeString: String {
        let hours = focusSecondsRemaining / 3600
        let minutes = (focusSecondsRemaining % 3600) / 60
        let seconds = focusSecondsRemaining % 60
        
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    
    // MARK: - Break
    
    var pauseSecondsRemaining = 0
    private var pauseTimer: Timer?
    var pauseTimerRunning = false
    
    var pauseTimeString: String {
        let minutes = pauseSecondsRemaining / 60
        let seconds = pauseSecondsRemaining % 60
        
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    
    // MARK: - Focus Timer
    
    func startFocusTimer() {
        focusSecondsRemaining = totalFocusTimerSeconds
        focusProgress = 0
        focusTimerRunning = true

        focusTimer = Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true
        ) { [weak self] _ in
            guard let self else { return }
            guard !self.pauseTimerRunning else {
                return
            }
            if self.focusSecondsRemaining > 0 {
                self.focusSecondsRemaining -= 1
                let newProgress =
                    1 - (
                        Double(self.focusSecondsRemaining) /
                        Double(self.totalFocusTimerSeconds)
                    )
                withAnimation(.linear(duration: 1)) {
                    self.focusProgress = newProgress
                }
            } else {
                self.finishFocusTimer()
            }
        }
    }
    
    
    func finishFocusTimer() {
        focusSecondsRemaining = 0
        focusProgress = 1
        focusTimer?.invalidate()
        focusTimer = nil
        
        focusTimerRunning = false
        focusTimerFinished = true
    }
    
    
    // MARK: - Break Timer
    
    func startPauseTimer() {
        guard !pauseTimerRunning else { return }
        withAnimation {
            pauseTimerRunning = true
        }
        pauseTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            
            guard let self else { return }
            if self.pauseSecondsRemaining > 0 {
                self.pauseSecondsRemaining -= 10
            } else {
                self.finishPauseTimer()
            }
        }
    }
    
    
    func finishPauseTimer() {
        pauseTimer?.invalidate()
        pauseTimer = nil
        withAnimation {
            pauseTimerRunning = false
        }
    }
    
    
    // MARK: - Stop Break Early
    
    func stopPauseTimer() {
        finishPauseTimer()
    }
}
