import Foundation
import CoreLocation

/// Includes name, coordinate, and an array of MenuItem
struct Restaurant: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
    var menu: [MenuItem]
}

