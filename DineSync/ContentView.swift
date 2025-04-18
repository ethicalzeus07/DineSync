import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppStateViewModel
    
    var body: some View {
        NavigationStack {
            if appState.isWelcomeScreenActive {
                // 1) Show the welcome screen if not dismissed
                WelcomeHomePage()
            } else if let restaurant = appState.selectedRestaurant {
                // 2) If a restaurant is selected, show the menu screen
                YelpMenuScreen(rest: restaurant)
            } else {
                // 3) Otherwise, show the map + restaurant list
                HomeMapView()
            }
        }
        .onAppear() {
            if (appState.yelpRestaurants.count == 0) {
                appState.searchRestaurants()
            }
            //appState.getMenu()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppStateViewModel())
    }
}

