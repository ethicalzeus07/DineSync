import SwiftUI
import MapKit

struct HomeMapView: View {
    @EnvironmentObject var appState: AppStateViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ZStack {
                    Map(coordinateRegion: $appState.region,
                        interactionModes: .all,
                        showsUserLocation: false,
                        annotationItems: appState.yelpRestaurants) { rest in
                        MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: rest.latitiude, longitude: rest.longitude)) {
                            VStack {
                                Text(rest.name)
                                    .font(.footnote)
                                    .padding(4)
                                    .background(Color.white.opacity(0.8))
                                    .cornerRadius(6)
                                Image(systemName: "mappin")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(.red)
                            }
                            .onTapGesture {
                                appState.selectRestaurant(rest)
                            }
                        }
                    }
                    .frame(height: 400)

                    
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            VStack(spacing: 8) {
                                // Zoom In
                                Button {
                                    let currSpan = appState.region.span
                                    
                                    let newLat = currSpan.latitudeDelta * 0.8
                                    let newLong = currSpan.longitudeDelta * 0.8
                                    appState.region.span = MKCoordinateSpan(
                                        latitudeDelta: newLat,
                                        longitudeDelta: newLong
                                    )
                                } label: {
                                    Image(systemName: "plus.magnifyingglass")
                                        .font(.title2)
                                        .padding(10)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .shadow(radius: 4)
                                }
                                
                                // Zoom Out
                                Button {
                                    let currSpan = appState.region.span
                                    // 120% => Zoom out
                                    let newLat = currSpan.latitudeDelta * 1.2
                                    let newLong = currSpan.longitudeDelta * 1.2
                                    appState.region.span = MKCoordinateSpan(
                                        latitudeDelta: newLat,
                                        longitudeDelta: newLong
                                    )
                                } label: {
                                    Image(systemName: "minus.magnifyingglass")
                                        .font(.title2)
                                        .padding(10)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .shadow(radius: 4)
                                }
                            }
                            .padding()
                        }
                    }
                }
                
                List(appState.yelpRestaurants) {res in
                    NavigationLink(destination: YelpMenuScreen(rest: res)) {
                        HStack {
                            Rectangle()
                                .fill(Color.blue)
                                .frame(width: 40, height: 40)
                                .cornerRadius(8)
                                .overlay(Text("Img").foregroundColor(.white))
                            Text(res.name)
                            Spacer()
                        }
                    }
                    
                }
                .onAppear() {
                    for res in appState.yelpRestaurants {
                        for itm in res.menu {
                            print(itm.foodName)
                        }
                        print("printed the items!")
                    }
                }
            }
            .navigationTitle("Nearby Restaurants")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Home Screen") {
                        appState.isWelcomeScreenActive = true
                    }
                }
            }
        }
    }
}
