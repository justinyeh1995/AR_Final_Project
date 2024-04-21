//
//  NodeInfoView.swift
//  CybORG-ARViz
//
//  Created by Justin Yeh on 4/21/24.
//

import SwiftUI

struct NodeInfoView: View {
    let nodeInfo: String
    let onClose: () -> Void
    
    var body: some View {
        VStack {
            Text("Node Information")
                .font(.title)
            
            Text(nodeInfo)
                .padding()
            
            Button("Close") {
                onClose()
            }
        }
    }
}

