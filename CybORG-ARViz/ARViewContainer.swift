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
        // Start AR session configuration here
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical] // Adjust based on your needs
        arView.session.run(config)
        
        // Optionally, load and place your 3D models in the AR scene
//        setupModels(in: arView)
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
    
//    private func setupModels(in arView: ARView) {
//        // Example of loading a 3D model named '3Dserver' from the app bundle and placing it in the AR scene
//        if let serverAnchor = try? Entity.load(named: "3Dserver") {
//            let anchor = AnchorEntity(plane: .horizontal)
//            anchor.addChild(serverAnchor)
//            arView.scene.addAnchor(anchor)
//        }
//        
//        // Repeat the above steps for other models like '3Dlink' and '3Dagents', adjusting positions as needed
//    }
}

