//
//  HomeView.swift
//  RealEstateAR
//
//  Created by Vedant Shah on 10/21/24.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import Firebase

struct HomeView: View {
    @State private var name = Auth.auth().currentUser?.displayName ?? "Unknown"
    
    var body: some View {
        Text("Hello \(name)")
    }
}

#Preview {
    HomeView()
}
