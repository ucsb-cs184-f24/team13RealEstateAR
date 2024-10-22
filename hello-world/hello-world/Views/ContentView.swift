//
//  ContentView.swift
//  hello-world
//
//  Created by Animesh on 07/10/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ContentViewModel()
    @State var proceed = false
    
    var body: some View {
        if proceed {
            if viewModel.isSignedIn && !viewModel.currentUserId.isEmpty {
                TabView {
                    MainView()
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }
                    ProfileView()
                        .tabItem {
                            Label("Profile", systemImage: "person.circle")
                        }
                }
            }
            else{
                LoginView()
            }
        } else {
            EntryView(proceed: $proceed)
        }
    }
}

#Preview {
    ContentView()
}
