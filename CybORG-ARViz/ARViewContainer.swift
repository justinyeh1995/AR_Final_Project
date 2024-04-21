//
//  ARViewContainer.swift
//  CybORG-ARViz
//
//  Created by Justin Yeh on 4/1/24.
//

import SwiftUI ///layout for the app
import UIKit ///use for handling screen Actions
import ARKit ///ARKit provides the real-world data and spatial context
import RealityKit ///RealityKit handles rendering and interaction with virtual content
import simd

/// From ARKit
struct ARViewContainer: UIViewRepresentable {
    typealias UIViewType = ARView
    
    var graphData: GraphWrapper? // Assume this is your graph data model passed in from ContentView
    // @To-Do: Group all the nodes and links together
    
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
        view.debugOptions = [.showFeaturePoints, .showWorldOrigin]
    }

    private func updateContent(for arView: ARView, graphData: GraphWrapper?) {
        print("--> In updateContent:")

        // Remove all existing anchors to clear previous content
        arView.scene.anchors.removeAll()
        
        
        // Create a new root anchor for this setup
        let rootAnchor = AnchorEntity()
        let parentModelEntity = ModelEntity()
        
        // Check and unwrap graphData
        if let graphData = graphData {
            print("----> compromised hosts is:\n")
            print(graphData.Red.compromised_hosts)
            // Create and add new nodes and links
            createNodes(in: arView, for: graphData.Red, parentModelEntity: parentModelEntity)
            createLinks(in: arView, for: graphData.Red, parentModelEntity: parentModelEntity)
            
            parentModelEntity.generateCollisionShapes(recursive: true)
            rootAnchor.addChild(parentModelEntity)
            arView.scene.addAnchor(rootAnchor)

            arView.installGestures([.all], for: parentModelEntity)
            
        }
        else {
            print("empty graphData")
        }
    }

    private func createNodes(in arView: ARView, for graphDetails: GraphDetails, parentModelEntity: ModelEntity) {
        print("---> In createNodes")
        
        for (index, node) in graphDetails.link_diagram.nodes.enumerated() {
            
            let colorName = graphDetails.node_colors[index]
            let nodePosition = graphDetails.node_positions[index]

            print("Node ID: \(nodePosition.id), X: \(nodePosition.x), Y: \(nodePosition.y), Z: \(nodePosition.z)")

            // Unwrap UIColor? first
            if let nodeColor = UIColor.from(colorName: colorName) {
                let sphere = ModelEntity(mesh: .generateSphere(radius: 0.05), materials: [SimpleMaterial(color: nodeColor, isMetallic: false)])
                sphere.position = SIMD3<Float>(nodePosition.x, nodePosition.y, nodePosition.z)// the position comes from the backend networkX algorithm
                sphere.addTextLabel(text: node.id, position: SIMD3<Float>(0, 0.1, 0))
                if node.id == "User0" || node.id == "Defender" {
                    sphere.addCharacter(node_id: node.id, position: SIMD3<Float>(0, 0.25, 0))
                }
                sphere.generateCollisionShapes(recursive: true)
                sphere.name = node.id // Set the name of the sphere
                
                parentModelEntity.addChild(sphere)
            } else {
                print("Could not find a matching color for name: \(graphDetails.node_colors[index])")
            }
        }
    }

    
    private func createLineEntity(from startPoint: SIMD3<Float>, to endPoint: SIMD3<Float>, thickness: Float) -> ModelEntity {
        let lineVector = endPoint - startPoint
        
        // Calculate the length of the line
        let length = simd_length(lineVector)
        
        // Generate a thin box with the length of the line
        let lineMesh = MeshResource.generateBox(size: [thickness, thickness, length])
        
        // Create a model entity with the generated mesh and a color material
        let lineEntity = ModelEntity(mesh: lineMesh, materials: [SimpleMaterial(color: .red, isMetallic: false)])
        
        // The default orientation of the box is along the z-axis.
        // Compute a quaternion that represents the rotation from the z-axis to the line vector
        let rotationQuaternion = simd_quatf(from: SIMD3<Float>(0, 0, 1), to: simd_normalize(lineVector))
        
        // Set the orientation of the line entity
        lineEntity.orientation = rotationQuaternion
        
        return lineEntity
    }
    
    private func createLinks(in arView: ARView, for graphDetails: GraphDetails, parentModelEntity: ModelEntity) {
        for link in graphDetails.link_diagram.links {
            //guard let sourceNode = arView.scene.findEntity(named: link.source),
            //      let targetNode = arView.scene.findEntity(named: link.target) else {
            guard let sourceNode = findEntity(named: link.source, parentModelEntity: parentModelEntity),
                  let targetNode = findEntity(named: link.target, parentModelEntity: parentModelEntity) else {
                print("Could not find nodes for link: \(link.source) to \(link.target)")
                continue
            }
            
            // Get the positions of the source and target nodes
            let sourcePosition = sourceNode.position
            let targetPosition = targetNode.position
            
            print("Start Point \(sourceNode.name): \(sourcePosition) - End Point \(targetNode.name) \(targetPosition)")
            
            // Create the line entity using the createLineEntity method
            let lineThickness: Float = 0.005 // Adjust thickness as needed
            let lineEntity = createLineEntity(from: sourcePosition, to: targetPosition, thickness: lineThickness)
            
            // Calculate the midpoint between the source and target positions
            let midPoint = (sourcePosition + targetPosition) / 2
            
            // Set the position of the line entity relative to the parent ModelEntity
            lineEntity.position = midPoint
            
            parentModelEntity.addChild(lineEntity)
        }
    }
    
    private func findEntity(named name: String, parentModelEntity: ModelEntity) -> Entity? {
        for child in parentModelEntity.children {
            if child.name == name {
                return child
            }
        }
        return nil
    }
}

extension Entity {
    /// Creates and returns a text entity.
    func createTextEntity(text: String, color: UIColor = .white) -> ModelEntity {
        let mesh = MeshResource.generateText(
            text,
            extrusionDepth: 0.01,
            font: .systemFont(ofSize: 0.04),
            containerFrame: CGRect.zero,
            alignment: .center,
            lineBreakMode: .byCharWrapping
        )
        let material = SimpleMaterial(color: color, roughness: 0.5, isMetallic: true)
        return ModelEntity(mesh: mesh, materials: [material])
    }

    /// Adds a text label as a child to the entity.
    func addTextLabel(text: String, position: SIMD3<Float>) {
        let textEntity = createTextEntity(text: text)
        textEntity.position = position
        textEntity.generateCollisionShapes(recursive: true)
        self.addChild(textEntity)
    }
    
    func createModelEntity(node_id: String) -> ModelEntity? {
        let fileName: String
        let fileExtension = "usdz"
        
        // Determine the file name based on the node_id
        switch node_id {
        case "User0":
            fileName = "red_hacker"
        case "Defender":
            fileName = "blue_hacker"
        default:
            print("Unknown node_id \(node_id).")
            return nil // Return nil if the node_id does not match
        }
        
        // Attempt to load the model from the filename, and return the result
        do {
            let modelEntity = try ModelEntity.loadModel(named: "\(fileName).\(fileExtension)")
            // Scale down the model. For example, 0.5 would make the model half its original size.
            let scale: Float = 0.2 // Adjust the scale factor as needed
            modelEntity.scale = SIMD3<Float>(repeating: scale)
            modelEntity.generateCollisionShapes(recursive: true)
            return modelEntity
        } catch {
            print("Failed to load modelEntity for \(node_id): \(error)")
            return nil
        }
    }
    
    func addCharacter(node_id: String, position: SIMD3<Float>) {
        if let modelEntity = createModelEntity(node_id: node_id) {
            modelEntity.position = position
            modelEntity.availableAnimations.forEach{modelEntity.playAnimation($0.repeat())}
            self.addChild(modelEntity)
        } else {
            print("Model entity could not be created for node_id \(node_id).")
        }
    }
}

extension UIColor {
    // A utility function to get UIColor from predefined color names
    static func from(colorName: String) -> UIColor? {
        switch colorName.lowercased() {
        case "red":
            return UIColor.red
        case "green":
            return UIColor.green
        case "blue":
            return UIColor.blue
        case "pink":
            return UIColor.systemPink
        case "orange":
            return UIColor.orange
        case "rosybrown":
            return UIColor(red: 188/255, green: 143/255, blue: 143/255, alpha: 1.0) // RosyBrown as per standard RGB
        default:
            print("Unsupported color name: \(colorName). Returning nil.")
            return nil
        }
    }
}

