//
//  CameraView.swift
//  RealEstateAR
//
//  Created by Vedant Shah on 10/21/24.
//

import SwiftUI
import ARKit
import SceneKit

struct ARView: UIViewRepresentable {
    func makeUIView(context: Context) -> ARSCNView {
        let sceneView = ARSCNView()
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
        return sceneView
    }

    func updateUIView(_ uiView: ARSCNView, context: Context) {
        // Update the view if needed
    }
}

struct CameraView: View {
    var body: some View {
        ZStack {
            ARView()
                .edgesIgnoringSafeArea(.all) // Full-screen AR view
        }
    }
}



#Preview {
    CameraView()
}
