//
//  HomeView.swift
//  RealEstateAR
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
                
                // Updated NavigationLink to go to AboutView instead of CameraView
                NavigationLink(destination: AboutView()) {
                    Text("Go to About Page")
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
