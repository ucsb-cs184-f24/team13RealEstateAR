//
//  ContentView.swift
//  RealEstateAR
//
//  Created by Vedant Shah on 10/7/24.
//

import SwiftUI
import CoreData
import CoreLocation

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
        
        @StateObject private var locationManager = LocationManager()
        @State private var propertyProfile: String = "No property data yet." // To display property data
        
        @FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
            animation: .default)
        private var items: FetchedResults<Item>

    var body: some View {
        VStack {
            if let locationStatus = locationManager.locationStatus {
                switch locationStatus {
                case .authorizedWhenInUse, .authorizedAlways:
                    Text("Latitude: \(locationManager.userLatitude)")
                    Text("Longitude: \(locationManager.userLongitude)")
                    Text("Heading: \(locationManager.userHeading)")
                    Text("Address: \(locationManager.userAddress)") // Display the address here
                case .denied:
                    Text("Location access denied. Please enable location services in settings.")
                case .notDetermined:
                    Text("Requesting location access...")
                default:
                    Text("Location status unknown.")
                }
            }
            // Display property profile result
                        Text("Property Profile Data:")
                        Text(propertyProfile)
                            .padding()
                        
                        // Button to trigger property profile querying
                        Button(action: {
                            queryPropertyProfile()
                        }) {
                            Text("Query")
                                .font(.title)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                }

    // Function to query property profile based on the user address
    private func queryPropertyProfile() {
        if locationManager.userAddress != "Searching for address..." && locationManager.userAddress != "Address not found" {
            // Split the address into address1 and address2
            let addressComponents = locationManager.userAddress.split(separator: ",")
            guard addressComponents.count >= 2 else {
                print("Invalid address format.")
                return
            }
            
            let address1 = String(addressComponents[0]) // Street number and street name
            let address2 = String(addressComponents[1]) // City, State, Zip
            
            // Fetch API key and make API call to fetch the property profile
            if let apiKey = getAPIKey() {
                fetchBasicProfile(address1: address1.trimmingCharacters(in: .whitespaces),
                                  address2: address2.trimmingCharacters(in: .whitespaces),
                                  apiKey: apiKey, completion: { result in
                    switch result {
                    case .success(let data):
                        if let responseString = String(data: data, encoding: .utf8) {
                            DispatchQueue.main.async {
                                propertyProfile = responseString // Update UI with property data
                            }
                        }
                    case .failure(let error):
                        print("Error fetching property profile: \(error)")
                    }
                })
            }
        }
    }
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
