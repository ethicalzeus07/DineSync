import SwiftUI
import MapKit

@MainActor
class AppStateViewModel: ObservableObject {
    @Published var isWelcomeScreenActive: Bool = true
    @Published var selectedRestaurant: Restaurant? = nil
    
    // Hardcoded restaurants
    @Published var restaurants: [Restaurant] = [
        Restaurant(
            name: "Pizza Palace",
            coordinate: CLLocationCoordinate2D(latitude: 33.427, longitude: -111.94),
            menu: [
                MenuItem(name: "Pepperoni Pizza", price: 10, desc: "Wood-fired pizza with pepperoni."),
                MenuItem(name: "Veggie Pizza", price: 11, desc: "Bell peppers, onions, mushrooms, olives.")
            ]
        ),
        Restaurant(
            name: "Taco Town",
            coordinate: CLLocationCoordinate2D(latitude: 33.426, longitude: -111.94),
            menu: [
                MenuItem(name: "Street Tacos", price: 3, desc: "Al pastor, onions, cilantro."),
                MenuItem(name: "Carne Asada Burrito", price: 9, desc: "Steak, guac, pico de gallo.")
            ]
        )
    ]
    
    
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 33.4255, longitude: -111.94),
        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
    )
    
    init() { }
    
    func selectRestaurant(_ restaurant: Restaurant) {
        selectedRestaurant = restaurant
    }
    
    func goHome() {
        selectedRestaurant = nil
    }
}
