import SwiftUI


struct YelpMenuScreen: View {
    let rest : YelpRestaurant
    var body: some View {
        Text(rest.name)
            .font(.title)
            VStack(alignment: .leading) {
                List(rest.menu) { item in
                    
                    Text(item.foodName)
                        .font(.headline)
                    //Note that there is already a $ in item price
                    Text("\(item.price) • \(item.details)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        
        //.navigationTitle("Menu")
        //.navigationBarTitleDisplayMode(.inline)
    }
}
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
