//
//  _84hw2App.swift
//  184hw2
//
//  Created by XUANHE ZHOU on 10/23/24.
//

import SwiftUI
import FirebaseCore

@main
struct _84hw2App: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
