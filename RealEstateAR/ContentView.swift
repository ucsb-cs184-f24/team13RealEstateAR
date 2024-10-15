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
