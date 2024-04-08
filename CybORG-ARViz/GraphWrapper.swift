//
//  GraphWrapper.swift
//  CybORG-ARViz
//
//  Created by Justin Yeh on 4/1/24.
//

import RealityKit

struct NetworkGraph: Codable {
    let nodes: [Node]
    let links: [Link]
}

struct Node: Codable {
    let id: String
}

struct Link: Codable {
    let source: String
    let target: String
}

struct ActionInfo: Codable {
    let action: String
    let success: String
}

struct Border: Codable {
    let width: Int
    let color: String
}

struct GraphDetails: Codable {
    let link_diagram: NetworkGraph
    let node_colors: [String]
    let node_borders: [Border]
    let compromised_hosts: [String]
    let host_info: [String]
    let action_info: ActionInfo
    let host_map: [String: String]
}

// Assuming "Blue" and "Red" have similar structure, create a wrapper
struct GraphWrapper: Codable {
    let Blue: GraphDetails
    let Red: GraphDetails
}


//struct NetworkDataResponse: Codable {
//    let Blue: BlueData
//    let Red: RedData
//    // Include other top-level fields as necessary
//
//    struct BlueData: Codable {
//        let link_diagram: LinkDiagram
//        let node_colors: [String]
//        let node_borders: [Border]
//        let compromised_hosts: [String]
//        let host_info: [String]
//        let action_info: ActionInfo
//        let host_map: [String: String]
//    }
//
//    struct RedData: Codable {
//        // Similar structure to BlueData
//    }
//
//    // Definitions for LinkDiagram, Border, ActionInfo, etc.
//}
