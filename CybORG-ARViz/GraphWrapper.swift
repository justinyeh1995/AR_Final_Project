//
//  GraphWrapper.swift
//  CybORG-ARViz
//
//  Created by Justin Yeh on 4/1/24.
//

import Foundation

//
//  GraphWrapper.swift
//  CybORG-ARViz
//
//  Created by Justin Yeh on 4/1/24.
//

import Foundation


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

// Assuming "Blue" and "Red" have similar structure, create a wrapper
struct GraphWrapper: Codable {
    let Blue: GraphDetails
    let Red: GraphDetails
}

struct GraphDetails: Codable {
    let link_diagram: NetworkGraph
    // Add other properties as needed
}
