import SwiftUI

struct WelcomeHomePage: View {
    @EnvironmentObject var appState: AppStateViewModel
    
    var body: some View {
        VStack(spacing: 20) {

            Image("DineSync")
                .resizable()
                .frame(width: 300, height: 300)
                .shadow(radius: 5)
            
            Text("Welcome to DineSync!")
                .font(.largeTitle).bold()
            
            Text("No restaurant currently visiting...")
                .foregroundColor(.secondary)
            
            Button("Explore Nearby Restaurants") {
                appState.isWelcomeScreenActive = false
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .navigationTitle("DineSync")
        .navigationBarBackButtonHidden(true)
    }
}

struct WelcomeHomePage_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeHomePage()
            .environmentObject(AppStateViewModel())
    }
}
