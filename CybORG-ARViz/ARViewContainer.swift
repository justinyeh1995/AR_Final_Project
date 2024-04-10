//
//  ARViewContainer.swift
//  CybORG-ARViz
//
//  Created by Justin Yeh on 4/1/24.
//

import SwiftUI
import ARKit
import RealityKit

//extension MeshResource {
//    static func generateLine(from start: SIMD3<Float>, to end: SIMD3<Float>, radius: Float) -> MeshResource {
//        let length = distance(start, end)
//        let cylinder = MeshResource.generateCylinder(radius: radius, height: length, radialSegments: 12)
//        return cylinder
//    }
//}

struct ARViewContainer: UIViewRepresentable {
    typealias UIViewType = ARView
    
    var graphData: GraphWrapper? // Assume this is your graph data model

    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true)
        arView.backgroundColor = .gray // Or any other noticeable color
        arView.debugOptions = [.showFeaturePoints, .showWorldOrigin]

        // Start AR session configuration here
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical] // Adjust based on your needs
        arView.session.run(config)
    
        // Initial nodes and links creation
        updateContent(for: arView, graphData: graphData)
        
        return arView
    }

    func updateUIView(_ view: ARView, context: Context) {
        // Here, update the AR view with new or changed data
        print("Graph Data Changed!")
        updateContent(for: view, graphData: graphData)
    }
    
    private func updateContent(for arView: ARView, graphData: GraphWrapper?) {
        print("--> In updateContent:")

        // Remove all existing anchors to clear previous content
        arView.scene.anchors.removeAll()

        // Check and unwrap graphData
        if let graphData = graphData {
            print("----> compromised hosts is:\n")
            print(graphData.Red.compromised_hosts)
            // Create and add new nodes and links
            createNodes(in: arView, for: graphData.Blue)
            // createLinks(in: arView, for: graphData.Blue) // Uncomment and implement createLinks if needed
        }
        else {
            print("empty graphData")
        }
    }

    private func createNodes(in arView: ARView, for graphDetails: GraphDetails) {
        print("---> In createNodes")
        for node in graphDetails.link_diagram.nodes {
            let sphere = ModelEntity(mesh: .generateSphere(radius: 0.3))
            sphere.position = SIMD3<Float>(0, 0, -0.5) // @To-Do: design a placing algorithm

            let anchorEntity = AnchorEntity(world: SIMD3<Float>(0, 0, -0.5)) // @To-Do: design a placing algorithm
            anchorEntity.addChild(sphere)
            arView.scene.addAnchor(anchorEntity)
            sphere.name = node.id // Set the name of the sphere
            //print("Node id: \(node.id)")
        }
    }

//    private func createLinks(in arView: ARView, for graphDetails: GraphDetails) {
//        for link in graphDetails.link_diagram.links {
//            guard let sourceNode = arView.scene.findEntity(named: link.source),
//                  let targetNode = arView.scene.findEntity(named: link.target) else {
//                continue
//            }
//            
//            // Calculate the vector from source to target and its magnitude
//            let direction = targetNode.position - sourceNode.position
//            let length = simd_length(direction)
//            
//            // Create a cylinder to represent the line
//            let lineEntity = ModelEntity(mesh: .generateLine(from: sourceNode.position, to: targetNode.position, radius: 0.005)) // Adjust radius as needed
//            lineEntity.model?.materials = [SimpleMaterial(color: .red, isMetallic: false)]
//            
//            // Calculate midpoint for positioning
//            let midpoint = (sourceNode.position + targetNode.position) / 2.0
//            lineEntity.position = midpoint
//            
//            // Calculate rotation to align with the direction vector
//            let rotation = simd_quatf(from: SIMD3<Float>(0, 0, 1), to: simd_normalize(direction))
//            lineEntity.orientation = rotation
//            
//            arView.scene.addAnchor(AnchorEntity(world: lineEntity.position))
//        }
//    }
}

