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
        NavigationView {
            VStack {
                Text("Hello \(name)")
                    .font(.largeTitle)
                
                NavigationLink(destination: CameraView()) {
                    Text("Go to Camera")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("Home")
        }
    }
}

#Preview {
    HomeView()
}
