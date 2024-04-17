//
//  ARViewContainer.swift
//  CybORG-ARViz
//
//  Created by Justin Yeh on 4/1/24.
//

import SwiftUI
import ARKit
import RealityKit
import simd

/// From ARKit
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
            createNodes(in: arView, for: graphData.Red)
            createLinks(in: arView, for: graphData.Red)
        }
        else {
            print("empty graphData")
        }
    }

    private func createNodes(in arView: ARView, for graphDetails: GraphDetails) {
        print("---> In createNodes")
        let rowCount = Int(sqrt(Double(graphDetails.link_diagram.nodes.count)))
        let spacing: Float = 0.5 // space between nodes
        
        for (index, node) in graphDetails.link_diagram.nodes.enumerated() {
            let row = index / rowCount
            let column = index % rowCount
            
            let x = Float(column) * spacing
            let y = Float(row) * spacing
            
            let colorName = graphDetails.node_colors[index]
            // Unwrap UIColor? first
            if let nodeColor = UIColor.from(colorName: colorName) {
                let sphere = ModelEntity(mesh: .generateSphere(radius: 0.05), materials: [SimpleMaterial(color: nodeColor, isMetallic: false)])
                sphere.position = SIMD3<Float>(x - spacing * Float(rowCount) / 2, y - spacing * Float(rowCount) / 2, -1)// @To-Do: design a placing algorithm
                sphere.addTextLabel(text: node.id, position: SIMD3<Float>(0, 0.1, 0))
                let anchorEntity = AnchorEntity(world: SIMD3<Float>(0, 0, 0)) // @To-Do: design a placing algorithm
                anchorEntity.addChild(sphere)
                arView.scene.addAnchor(anchorEntity)
                sphere.name = node.id // Set the name of the sphere
                //print("Node id: \(node.id)")
            } else {
                print("Could not find a matching color for name: \(graphDetails.node_colors[index])")
            }
        }
    }

    
    // Example function to create a thin box to simulate a line
    private func createLineEntity(from startPoint: SIMD3<Float>, to endPoint: SIMD3<Float>, thickness: Float) -> AnchorEntity {
        let lineVector = endPoint - startPoint
        
        // Calculate the midpoint where the line entity will be anchored
        let midPoint = (startPoint + endPoint) / 2
        
        // Calculate the length of the line
        let length = simd_length(lineVector)
        
        // Generate a thin box with the length of the line
        let lineMesh = MeshResource.generateBox(size: [thickness, thickness, length])
        
        // Create a model entity with the generated mesh and a color material
        let lineEntity = ModelEntity(mesh: lineMesh, materials: [SimpleMaterial(color: .red, isMetallic: false)])
        
        // The default orientation of the box is along the z-axis.
        // Compute a quaternion that represents the rotation from the z-axis to the line vector
        let rotationQuaternion = simd_quatf(from: SIMD3<Float>(0, 0, 1), to: simd_normalize(lineVector))
        
        // Create the line entity and set its transform
        let lineAnchor = AnchorEntity(world: midPoint)
        lineAnchor.addChild(lineEntity)
        lineAnchor.orientation = rotationQuaternion
        
        return lineAnchor

    }
    
    private func createLinks(in arView: ARView, for graphDetails: GraphDetails) {
        for link in graphDetails.link_diagram.links {
            guard let sourceNode = arView.scene.findEntity(named: link.source),
                  let targetNode = arView.scene.findEntity(named: link.target) else {
                continue
            }
            
            // Get the positions of the source and target nodes
            let sourcePosition = sourceNode.position
            let targetPosition = targetNode.position
            
            print("Start Point \(sourceNode.name): \(sourcePosition) - End Point \(targetNode.name) \(targetPosition)")
            
            // Create the line entity using the createLineEntity method
            let lineThickness: Float = 0.005 // Adjust thickness as needed
            let lineEntity = createLineEntity(from: sourcePosition, to: targetPosition, thickness: lineThickness)
            
            arView.scene.addAnchor(lineEntity)
        }
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
        let material = SimpleMaterial(color: color, isMetallic: true)
        return ModelEntity(mesh: mesh, materials: [material])
    }

    /// Adds a text label as a child to the entity.
    func addTextLabel(text: String, position: SIMD3<Float>) {
        let textEntity = createTextEntity(text: text)
        textEntity.position = position
        self.addChild(textEntity)
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

extension MeshResource {
    /// Generates a very thin box standing vertically along the Y-axis.
    static func generateLine(from start: SIMD3<Float>, to end: SIMD3<Float>, radius: Float) -> MeshResource {
        // Calculate the distance between the start and end points to determine the depth of the box.
        let distance = simd_distance(start, end)
        
        // Use a very small value for width and height to make the box thin, like a line.
        let width = radius  // This will serve as the "thickness" of the line.
        let height = radius // Same as width to ensure the line's thickness is uniform.
        
        // Generate a box with the desired dimensions.
        // The depth of the box will be equal to the distance between the start and end points.
        let line = MeshResource.generateBox(width: width, height: height, depth: distance)
        
        return line
    }
}
