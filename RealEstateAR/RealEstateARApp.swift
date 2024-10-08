//
//  RealEstateARApp.swift
//  RealEstateAR
//
//  Created by Vedant Shah on 10/7/24.
//

import SwiftUI

@main
struct RealEstateARApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
