//
//  ARViewCoordinator.swift
//  CybORG-ARViz
//
//  Created by Justin Yeh on 4/21/24.
//

import RealityKit
import UIKit ///use for handling screen Actions


class ARViewCoordinator: NSObject {
    weak var view: ARView?
    var networkStateManager: NetworkStateManager?
    var selectedNode: ModelEntity?
    //var nodeInfoCancellable: AnyCancellable?
        
    
    /// objective-c
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
                
        guard let view = self.view else { return }

        let tapLocation = recognizer.location(in: recognizer.view)
        
        if let entity = view.entity(at: tapLocation) as? ModelEntity, !entity.name.isEmpty {
        }
        
    }
}
