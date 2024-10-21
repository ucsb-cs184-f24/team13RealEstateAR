//
//  About.swift
//  RealEstateAR
//
//  Created by Leo Guo on 10/21/24.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            // Title
            Text("About Us")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            // Project Description
            Text("Welcome to our AR RealEstate project! This app revolutionizes the way you explore properties by integrating augmented reality and real-time data from various sources. Simply point your camera at any house, and our app will display detailed property information, including prices, valuations, and more. Discover properties like never before with our innovative technology.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
        }
        .padding()
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
