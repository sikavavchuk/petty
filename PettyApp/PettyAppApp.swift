import SwiftUI
import SwiftData

@main
struct PettyAppApp: App {
    
    @State private var path = NavigationPath()
    @State private var mainModel = MainScreenViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $path) {
                
                MainScreenView(path: $path)
                
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                            
                        case .selection:
                            SelectionScreenView(
                                path: $path
                            )
                            
                        case .session(let totalTimeSeconds, let breakTime):
                            SessionScreenView(
                                path: $path,
                                totalTimerSeconds: totalTimeSeconds,
                                breakTime: breakTime
                            )
                        }
                        
                    }
                    .environment(mainModel)
            }
        }
        
    }
}
