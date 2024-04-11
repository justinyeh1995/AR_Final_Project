# AR Interface for Network Simulation and Cyber Operations Research Gym (CybORG) Interaction

## Project Description

### 1. Objective:
This project seeks to innovate in the field of cyber operations research by employing ARKit to develop an immersive tool for visualizing the results of the Cyber Operations Research Gym (CybORG) games on iOS devices. Acknowledging the challenge of presenting the complex, dynamic outcomes of CybORG simulations on conventional displays, our initiative aims to leverage augmented reality's spatial and interactive capabilities. This approach will transform how users comprehend and analyze CybORG game outcomes, making detailed cyber operations data more accessible, engaging, and understandable.

### 2. Technology Stack:
AR Technology: Utilizing ARKit, with a focus on its advanced world tracking, plane detection, and spatial anchoring features, to create stable and interactive AR experiences tailored for visualizing CybORG game data.
Development Environment: Unity integrated with the ARKit plugin, offering a robust platform for building detailed AR visualizations that effectively convey the complexities of cyber operations research.
Data Integration: Implementing REST API calls to fetch real-time or historical CybORG game results, ensuring the visualization accurately reflects the nuanced dynamics of cyber operations simulations.

Technical Implementation in ARKit:
- 3D Models for Nodes: Create or import 3D models to represent different types of nodes (servers, routers, workstations) in Unity.
- ARKit Plane Detection: Use ARKit’s plane detection to place the network simulation on a flat surface, like a table or floor, allowing users to view it from a comfortable perspective.
- Touch Gestures: Implement gesture recognition to allow users to interact with the network. Simple gestures like a tap could reveal more information, and pinch or swipe gestures could navigate through simulation steps or scale the visualization.

Backend API Service Code can be found at: \
https://github.com/justinyeh1995/CybORG-live/blob/main/src/api/v1/CybORG/CybORG/FastAPI/fastapi_index.py

### 3. Project Scope:
CybORG Data Visualization: Creating an intuitive AR interface that allows users to navigate and interact with 3D representations of CybORG game results, highlighting key metrics, attack vectors, and defense mechanisms within a cyber operations scenario.
Adaptive Display for Detailed Analysis: The application will enable users to scale and manipulate the spatial visualization of game results, accommodating the need for detailed analysis without being constrained by the screen size limitations of iPhones and iPads.
Research and Educational Impact: While the tool is designed to support cyber operations researchers in analyzing CybORG simulations, it also serves an educational purpose, demystifying complex cyber security concepts for students and professionals alike.

![newplot](https://github.com/justinyeh1995/AR_Final_Project/assets/42970023/a95642d8-81fb-44f6-b24e-c06be1edaa6f)
