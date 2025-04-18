import SwiftUI
import MapKit

@MainActor
class AppStateViewModel: ObservableObject {
    @Published var isWelcomeScreenActive: Bool = true
    @Published var selectedRestaurant: YelpRestaurant? = nil
    
    let apiKey = "BvV4FyHjtAVK-zsSI3VLWwvz-zXGgF3VrfShyqIxO92o4Vr6vvU1mM3PAhGvsgc7Q_r_zEMIH-tk" +
    "qfTfQ_VScEhHsDcILpUoUzU9nWVK5frkcdCo8Zb6TSXR3f7-Z3Yx"
    
    let clientId = "a2xu9-kp3KaPy9lM3GE2wA"
    
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
    
    @Published var yelpRestaurants: [YelpRestaurant] = []
    
    
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 33.4255, longitude: -111.94),
        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
    )
    
    init() { }
    func getMenu(biz : YelpRestaurant) {
        print("got menu")
        var res : [YelpMenuItem] = []
        //this gets all menu items for a given business (provided the id of the business...
        let id = ""
        let headers = ["x-rapidapi-host": "yelp-business-api.p.rapidapi.com", "x-rapidapi-key" : "2f737ab37bmsh45321366090f2f9p17a156jsn20ba0f7b4de5"]

        var request = URLRequest(url: NSURL(string: "https://yelp-business-api.p.rapidapi.com/get_menus?business_id=xTAW1Eewne6_bkvKcQM2Mg")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let jsonQuery = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            if (error != nil) {
                print(error!.localizedDescription)
            }
            do {
                print("jsonfetching")
                if let dat = try JSONSerialization.jsonObject(with: data ?? Data()) as? [String : Any] {
                    if let menuItems = dat["menus"] as? [[String : Any]] {
                        //print(menuItems)
                        for itm in menuItems {
                            print(itm["Food Name"] as! String)
                            res.append(YelpMenuItem(foodName: itm["Food Name"] as! String, details: itm["Details"] as! String, price: itm["Price"] as! String))
                        }

                        
                        //"Food Name" : "ARANCINI",
                        //"Details" : "Risotto | Mozzarella | Peas | House made Pomodoro | Calabrian Aioli",
                        //"Price" : "$15.00"
                        
                    }
                }
                biz.menu = res
                DispatchQueue.main.async() {
                    self.yelpRestaurants.append(biz)
                }
//let string = try JSONSerialization.data(withJSONObject: dat, options: .prettyPrinted)
                //if let jsonString = String(data: string, encoding: .utf8) {
                //           print(jsonString)
                //       }
                /*
                let decodedData = try JSONDecoder().decode(citydata.self, from: data!)
                if (decodedData.geonames.count > 10) {
                    decodedData.geonames =  Array(decodedData.geonames[0...10])
                }
                DispatchQueue.main.async {
                    self.places = decodedData.geonames
                }
                 */
            } catch {
                print("error: \(error)")
            }
        })
        jsonQuery.resume()

        
       
    }
    

    
    func searchRestaurants() {
        //check if in restaurant... search with radius of 1?
        
        //gets all business as a json list.
        let latitude = "33.41871621323409"
        let longitude = "-111.922018682808"
        let urlString = "https://api.yelp.com/v3/businesses/search?term=restaurants&latitude=\(latitude)&longitude=\(longitude)&limit=5"
        
        //let urlString = "https://api.yelp.com/v3/businesses/xTAW1Eewne6_bkvKcQM2Mg/insights/food_and_drinks"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        let urlSession = URLSession.shared
        let jsonQuery = urlSession.dataTask(with: request, completionHandler: { data, response, error -> Void in
            if (error != nil) {
                print(error!.localizedDescription)
            }
            var err: NSError?
            do {
                //welcome to type conversion hell
                print("jsonfetching businesses")
                if let dat = try JSONSerialization.jsonObject(with: data ?? Data()) as? [String : Any] {
                    //[[String: Any]] is list of array///
                    for i in dat["businesses"] as! [[String : Any]] {
                       
                        let coords = i["coordinates"] as! [String : Double]
                        var biz = YelpRestaurant(id: i["id"] as! String, name: i["alias"] as! String, latitiude: coords["latitude"]!,
                                                 longitude: coords["longitude"]!, menu: [] )
                        DispatchQueue.main.async() {
                            self.getMenu(biz: biz)
                        //biz.menu = self.getMenu(id: i["id"] as! String)
                            
                            //the getMenu actually appends?
                        //print(i["alias"])
                    
                        //self.yelpRestaurants.append(biz)
                        }
                        
                        
                    }

                    
                }
            } catch {
                print("error: \(error)")
            }
        })
        jsonQuery.resume()
    }
    
    func loadRestaurantData(handler: @escaping () -> Void) {
        self.searchRestaurants()
    }
    
    func selectRestaurant(_ restaurant: YelpRestaurant) {
        selectedRestaurant = restaurant
    }
    
    func goHome() {
        selectedRestaurant = nil
    }
}
