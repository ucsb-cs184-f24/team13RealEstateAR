//
//  ContentView.swift
//  hello-world
//
//  Created by Animesh on 07/10/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ContentViewModel()
    @State var proceed: Bool = false
    
    var body: some View {
        if proceed {
            if viewModel.isSignedIn && !viewModel.currentUserId.isEmpty {
                MainView()
            }
            else{
                LoginView()
            }
        }
        else {
            EntryView(proceed: $proceed)
        }
    }
}

#Preview {
    ContentView()
}
