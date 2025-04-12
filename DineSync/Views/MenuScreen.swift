import SwiftUI

struct MenuScreen: View {
    let restaurant: Restaurant
    
    var body: some View {
        List(restaurant.menu) { item in
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text("$\(item.price) • \(item.desc)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .navigationTitle("Menu")
        .navigationBarTitleDisplayMode(.inline)
    }
}
