//
//  NetworkStateManager.swift
//  CybORG-ARViz
//
//  Created by Justin Yeh on 4/21/24.
//

import Foundation ///@Published is from here
import simd

class NetworkStateManager: ObservableObject {
    @Published var networkStates: [NetworkState] = []
    
    func addState(_ state: NetworkState) {
        networkStates.append(state)
    }
}

/// Used to store the orientations of the network in a certain step
struct NetworkState {
    let position: SIMD3<Float>
    let scale: Float
    let rotation: simd_quatf
}
