//
//  ObservationInfo.swift
//  CybORG-ARViz
//
//  Created by Justin Yeh on 4/23/24.
//

import SwiftUI

struct ObservationInfoView: View {
    let red_info: ActionInfo
    let blue_info: ActionInfo
    @State private var isExpanded: Bool = true  // State to track whether details are expanded or not
    
    var body: some View {
        VStack {
            if isExpanded {
                Text("👮‍♀️ Blue \(blue_info.action), Action Succees: \(blue_info.success)\n👺 Red \(red_info.action), Action Succees: \(red_info.success)")
                    .padding()
                Button("Show Less") {
                    // Toggle the state to show less details
                    isExpanded.toggle()
                }
            } else {
                HStack {
                    Text("Actions & Observations").bold()
                    Button("See More") {
                        // Toggle the state to show more details
                        isExpanded.toggle()
                    }
                }
            }
        }
    }
}
