import Foundation

/// Represents a single menu entry
class MenuItem: Identifiable {
    let id = UUID()
    var name: String
    var price: Int
    var desc: String
    
    init(name: String, price: Int, desc: String) {
        self.name = name
        self.price = price
        self.desc = desc
    }
}

