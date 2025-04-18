import Foundation
import CoreLocation

/// Includes name, coordinate, and an array of MenuItem
///

struct Restaurant: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
    var menu: [MenuItem]
}

class YelpRestaurant : Codable, Identifiable, @unchecked Sendable{
    //unchecked sendable is bad :)
    var id: String
    var name: String
    var latitiude : CLLocationDegrees
    var longitude : CLLocationDegrees
    var menu : [YelpMenuItem]
    //var
    init(id: String, name: String, latitiude: CLLocationDegrees, longitude: CLLocationDegrees, menu: [YelpMenuItem]) {
        self.id = id
        self.name = name
        self.latitiude = latitiude
        self.longitude = longitude
        self.menu = menu
    }

}


struct YelpMenuItem : Codable, Identifiable {
    var id = UUID()
var foodName : String //json attr is "Food Name"
var details: String // "Detail"
var price : String // "Price"
    
    

}

struct businesses: Codable {
    var businessList : [YelpRestaurant]
}


