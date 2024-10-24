//
//  HomeView.swift
//
//  Created by Angel Gutierrez on 10/23/24.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    @State private var name = Auth.auth().currentUser?.displayName ?? "Unknown"
    
    var body: some View {
        TabView {
            VStack {
                Text("How's it going, \(name)?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                Spacer()
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            
            LibraryView()
                .tabItem {
                    Label("Library", systemImage: "books.vertical.fill")
                }
        }
    }
}

#Preview {
    HomeView()
}
