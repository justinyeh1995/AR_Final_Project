//
//  ContentView.swift
//  CybORG-ARViz
//
//  Created by Justin Yeh on 3/31/24.
//

import SwiftUI

struct GameStartResponse: Codable {
    let game_id: String
}

struct GameEndResponse: Codable {
    let message: String
}

/// Main Scene
struct ContentView: View {
    @State private var graphData: GraphWrapper?
    @State private var gameID: String?
    @State private var isLoading = false
    @State private var maxSteps = 10
    @State private var currStep = 0
    @State private var redAgent = "B_lineAgent"
    @State private var blueAgent = "BlueRemove"
    @State private var nodeInfoVisible = false
    @State private var selectedNodeInfo: String = ""
    
    var body: some View {
        VStack {
            ARViewContainer(graphData: graphData, maxSteps: maxSteps, redAgent: redAgent, blueAgent: blueAgent)
                .edgesIgnoringSafeArea(.all)
            
            // Display loading or game ID information
            if isLoading {
                ProgressView()
            } else if let gameID = gameID {
                //Text("Game ID: \(gameID) has started")
                if currStep == maxSteps {
                    Text("End of Game!")
                }
                Text("Game has started - Round: \(currStep)")
            } else {
                Text("No Game has started yet")
            }
            
            // Control buttons grouped together
            VStack {
                // Game control buttons
                HStack {
                    Spacer()
                    Button(action: startSimulation) {
                        Image(systemName: "play.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding()
                    }
                    .disabled(gameID != nil) // Disable this button if a gameID exists
                    
                    Spacer()
                    Button(action: previousStep) {
                        Image(systemName: "backward.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding()
                    }
                    .disabled(gameID == nil || currStep <= 0) // Disable if no gameID or on the first step
                    
                    Spacer()
                    Button(action: nextStep) {
                        Image(systemName: "forward.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding()
                    }
                    .disabled(gameID == nil || currStep >= maxSteps) // Disable if no gameID or reached max steps
                    
                    Spacer()
                    Button(action: endSimulation) {
                        Image(systemName: "stop.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding()
                    }
                    .disabled(gameID == nil) // Disable this button if no gameID exists
                    
                    Spacer()
                }
            }
        }
    }
    
    func startSimulation() {
        Task {
            isLoading = true
            
            let fetchedGameID = await fetchStartGame(blueAgent: blueAgent, redAgent: redAgent, maxSteps: maxSteps)
            gameID = fetchedGameID
            
            isLoading = false
        }
    }
    
    func nextStep() {
        Task {
            isLoading = true
            
            if currStep == maxSteps {
                print("End of game")
            } else if let networkDataResponse = await fetchGraphData(gameID: gameID) {
                graphData = networkDataResponse
                currStep += 1
            } else {
                print("Failed to fetch network data.")
            }
            
            isLoading = false
        }
    }
    
    func previousStep() {
        // Implement previous step logic here
    }
    
    func endSimulation() {
        Task {
            isLoading = true
            
            let message = await fetchEndGame(gameID: gameID)
            if message != nil {
                DispatchQueue.main.async {
                    self.gameID = nil
                }
            }
            graphData = nil
            currStep = 0
            
            isLoading = false
        }
    }
}

/// Fetch Data from backend server
/// Start Game
func fetchStartGame (blueAgent: String, redAgent: String, maxSteps: Int) async -> String? {
        let urlString = "https://justinyeh1995.com/api/game/"
        //let urlString = "http://localhost:8000/api/game/"

        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["red_agent": "B_lineAgent", "step": maxSteps, "blue_agent": "BlueRemove"]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            let (data, response) = try await URLSession.shared.data(for: request)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                print("Error: HTTP status code is not 200")
                return nil
            }
   
            let responseData = try JSONDecoder().decode(GameStartResponse.self, from: data)

            print("Fetched Game ID: \(responseData.game_id)")
            return responseData.game_id
            
        } catch {
            print("Networking or Decoding Error: \(error.localizedDescription)")
            return nil
        }
}

/// Fetch Next Step
func fetchGraphData(gameID: String?) async -> GraphWrapper? {
    guard let gameID = gameID else {
        print("Start Game first")
        return nil
    }
    
    let urlString = "https://justinyeh1995.com/api/game/" + gameID
    //let urlString = "http://localhost:8000/api/game/" + gameID

    guard let url = URL(string: urlString) else {
        print("Invalid URL")
        return nil
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"

    do {
        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            print("Error: HTTP status code is not 200")
            return nil
        }
        
        // Directly decode using the 'data' received from the network request
        do {
            let decoder = JSONDecoder()
            let responseData = try decoder.decode(GraphWrapper.self, from: data)
            return responseData
        } catch {
            print("Decoding failed with error: \(error)")
            return nil
        }
    } catch {
        print("Networking or Decoding Error: \(error.localizedDescription)")
        return nil
    }
}

/// Delete Game
func fetchEndGame(gameID: String?) async -> String? {
    guard let gameID = gameID else {
        print("Start Game first")
        return nil
    }
    
    let urlString = "https://justinyeh1995.com/api/game/" + gameID
    //let urlString = "http://localhost:8000/api/game/" + gameID

    guard let url = URL(string: urlString) else {
        print("Invalid URL")
        return nil
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "DELETE"

    do {
        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            print("Error: HTTP status code is not 200")
            return nil
        }
        
        // Print the raw JSON string for debugging
        if let jsonString = String(data: data, encoding: .utf8) {
            print("Raw JSON string:\n\(jsonString)")
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let responseData = try decoder.decode(GameEndResponse.self, from: data)
        
        print("Deleted Game ID: \(gameID), message: \(responseData.message)")
        return responseData.message
        
    } catch {
        print("Networking or Decoding Error: \(error.localizedDescription)")
        return nil
    }
}

#Preview {
    ContentView()
}
