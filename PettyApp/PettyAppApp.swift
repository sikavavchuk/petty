import SwiftUI
import SwiftData

@main
struct PettyAppApp: App {

    @State private var path = NavigationPath()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $path) {

                MainScreenView(path: $path)

                    .navigationDestination(for: Route.self) { route in
                        switch route {

                        case .selection:
                            SelectionScreenView(path: $path)

                        case .session:
                            SessionScreenView(path: $path)
                        }
                    }
            }
        }
    }
}

