//
//  LoginView.swift
//  RealEstateAR
//
//  Created by Vedant Shah on 10/15/24.
//

import Foundation
import SwiftUI

struct LoginView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        VStack {
            Text("AR Realtor")
                .font(.largeTitle)
        }
        
        Button(action: signIn) {
            Image("google") // Use the name of your custom image
                .resizable()
                .frame(width: 50, height: 50) // Adjust the size of the image
        }
    }
    
    private func signIn() {
        
    }
}

#Preview {
    LoginView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
