//
//  ARViewContainer.swift
//  CybORG-ARViz
//
//  Created by Justin Yeh on 4/1/24.
//

import SwiftUI
import ARKit
import RealityKit

struct ARViewContainer: UIViewRepresentable {
    typealias UIViewType = ARView
    
    var graphData: GraphWrapper? // Assume this is your graph data model

    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true)
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        // Use graphData to update your AR scene
        if let graphData = graphData {
            // Clear existing anchors if any
            uiView.scene.anchors.removeAll()
            
            // Setup the AR content with the new graph data
//            setupGraphInView(arView: uiView, graphData: graphData)
        }
    }
    
    private func setupGraphInView(arView: ARView, graphData: GraphWrapper) {
        // Here you would convert your graphData to 3D models and place them in the AR scene.
        // This is a placeholder for where you would implement the visualization based on your graphData.
        
        // Example: Create an anchor and add entities to it
//        let anchor = AnchorEntity(plane: .horizontal)
//        // Add nodes and links as entities to the anchor
//        // ...
//        arView.scene.addAnchor(anchor)
    }
}

