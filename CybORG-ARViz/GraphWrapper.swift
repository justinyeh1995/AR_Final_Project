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

struct NodePosition: Codable {
    let id: String
    let x: Float
    let y: Float
    let z: Float
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
    let node_positions: [NodePosition]
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

