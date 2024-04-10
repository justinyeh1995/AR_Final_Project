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

struct ContentView: View {
    @State private var graphData: GraphWrapper?
    @State private var gameID: String?
    @State private var isLoading = false
    
    var body: some View {
        VStack {
            ARViewContainer(graphData: graphData)
                .edgesIgnoringSafeArea(.all)
            if isLoading {
                ProgressView()
            } else if let gameID = gameID {
                Text("Game ID: \(gameID)")
            } else {
                Text("No Game ID fetched yet")
            }
            Button("Start CybORG Simulation") {
                Task {
                    isLoading = true
                    let fetchedGameID = await fetchStartGame()
                    gameID = fetchedGameID
                    isLoading = false
                }
            }
            Button("Next Step") {
                Task {
                    if let networkDataResponse = await fetchGraphData(gameID: gameID) {
                        // Process the networkDataResponse here
                        graphData = networkDataResponse
                    } else {
                        print("Failed to fetch network data.")
                    }
                }
            }
            Button("Previous Step") {
            
            }
            Button("End Simulation") {
                Task {
                    // Call the API to end the game
                    let message = await fetchEndGame(gameID: gameID)
                    if message != nil {
                        // Reset gameID only on successful API call
                        DispatchQueue.main.async {
                            self.gameID = nil
                        }
                    }
                    graphData = nil // Clear graphData after backend responses
                }
            }
        }

    }
}

func fetchStartGame () async -> String? {
        let urlString = "https://justinyeh1995.com/api/game/"
        //let urlString = "http://localhost:8000/api/game/"

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

// Place your fetchGraphData function here
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

// Delete Game
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
