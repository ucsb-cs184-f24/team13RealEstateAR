//
//  hello_worldApp.swift
//  hello-world
//
//  Created by Animesh on 07/10/24.
//

import FirebaseCore
import SwiftUI

@main
struct hello_worldApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
