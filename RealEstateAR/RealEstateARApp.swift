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
            LoginView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
