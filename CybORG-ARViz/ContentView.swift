//
//  ContentView.swift
//  CybORG-ARViz
//
//  Created by Justin Yeh on 3/31/24.
//

import SwiftUI

struct ContentView: View {
    @State private var graphData: GraphWrapper?
    @State private var gameID: Int?
    @State private var isLoading = false
    
    var body: some View {
        VStack {
            ARViewContainer(graphData: graphData)
                .edgesIgnoringSafeArea(.all)
            Button("Start CybORG Simulation") {
                Task {
                        self.gameID = await fetchStartGame()
                    }
            }
            Button("Next Step") {
            
            }
            Button("Previous Step") {
            
            }
            Button("End Simulation") {
            
            }
        }
        if let gameID = gameID {
            Text("Game ID: \(gameID)")
        } else {
            Text("No Game ID fetched yet")
        }
    }
}

func fetchStartGame () async -> Int? {
        let urlString = "http://localhost:8000/api/game/"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["red_agent": "B_lineAgent", "step": 10, "blue_agent": "BlueRemove"]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            print(request)
            let (data, response) = try await URLSession.shared.data(for: request)
            print("hey")
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                print("Error: HTTP status code is not 200")
                return nil
            }
            
            let gameID = try JSONDecoder().decode(Int.self, from: data)
            print("Fetched Game ID: \(gameID)")
            return gameID
        } catch {
            print("Networking or Decoding Error: \(error.localizedDescription)")
            return nil
        }
}

// Place your fetchGraphData function here
func fetchGraphData(completion: @escaping (GraphWrapper?) -> Void) {
    // Implementation...
}

#Preview {
    ContentView()
}
