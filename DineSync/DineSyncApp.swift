import SwiftUI

@main
struct DineSyncApp: App {
    @StateObject private var appState = AppStateViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
    }
}

