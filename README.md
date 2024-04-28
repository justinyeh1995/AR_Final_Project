# iOS App for Visualizing Network Simulation and Cyber Operations Research Gym (CybORG) Interaction

## Setup Instructions
1. Download Xcode
2. Clone the repository: `git clone https://github.com/justinyeh1995/CybORG-ARViz.git`
 
## Running the App
To run the app on your device, follow these steps:

1. Open the project in Xcode.
2. Connect your iOS device(I'm using iPad 10th gen) via USB or USBC.
3. Select your device from the target dropdown in Xcode.
4. Click Run to build and deploy the application to your device.
![326292281-fab07077-90c8-454d-924a-defe0b03a34c 2](https://github.com/justinyeh1995/CybORG-ARViz/assets/42970023/a45e956f-cf2c-4b92-9948-e0802f0c2914)


## Project Description

### 1. Objective:
This project seeks to innovate in the field of cyber operations research by employing ARKit to develop an immersive tool for visualizing the results of the Cyber Operations Research Gym (CybORG) games on iOS devices. Acknowledging the challenge of presenting the complex, dynamic outcomes of CybORG simulations on conventional displays, our initiative aims to leverage augmented reality's spatial and interactive capabilities. This approach will transform how users comprehend and analyze CybORG game outcomes, making detailed cyber operations data more accessible, engaging, and understandable.

### 2. Technology Stack:
AR Technology: Utilizing ARKit, with a focus on its advanced world tracking, plane detection, and spatial anchoring features, to create stable and interactive AR experiences tailored for visualizing CybORG game data.
Development Environment: Unity integrated with the ARKit plugin, offering a robust platform for building detailed AR visualizations that effectively convey the complexities of cyber operations research.
Data Integration: Implementing REST API calls to fetch real-time or historical CybORG game results, ensuring the visualization accurately reflects the nuanced dynamics of cyber operations simulations.

Technical Implementation in ARKit:
- Swift & SwitUI for iOS dev
- RealityKit for 3D Models rendering.
- ARKit Plane Detection: Use ARKit’s plane detection to place the network simulation on a flat surface, like a table or floor, allowing users to view it from a comfortable perspective.
- Touch Gestures: Implement gesture recognition to allow users to interact with the network. Simple gestures like a tap could reveal more information, and pinch or swipe gestures could navigate through simulation steps or scale the visualization.

Backend API Service Code can be found at: \
https://github.com/justinyeh1995/CybORG-live/blob/main/src/api/v1/CybORG/CybORG/FastAPI/fastapi_index.py

### 3. Project Scope:
CybORG Data Visualization: Creating an intuitive AR interface that allows users to navigate and interact with 3D representations of CybORG game results, highlighting key metrics, attack vectors, and defense mechanisms within a cyber operations scenario.
Adaptive Display for Detailed Analysis: The application will enable users to scale and manipulate the spatial visualization of game results, accommodating the need for detailed analysis without being constrained by the screen size limitations of iPhones and iPads.
Research and Educational Impact: While the tool is designed to support cyber operations researchers in analyzing CybORG simulations, it also serves an educational purpose, demystifying complex cyber security concepts for students and professionals alike.

![newplot](https://github.com/justinyeh1995/AR_Final_Project/assets/42970023/a95642d8-81fb-44f6-b24e-c06be1edaa6f)
