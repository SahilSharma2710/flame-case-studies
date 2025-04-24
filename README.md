# 🔥 Flutter Flame Engine Case Studies

Welcome to the **Flutter Flame Engine Case Studies** repository!  
This repo is a curated collection of mini projects and case-study-style games built using [Flame](https://flame-engine.org/), the lightweight game engine for Flutter. Each project demonstrates a specific concept or mechanic to help learners and developers understand how to build games with Flame.

## 📚 Purpose

The goal of this repository is to:
- Showcase different game mechanics and use-cases using the Flame engine.
- Help developers understand and learn Flame with hands-on, practical examples.
- Serve as a quick reference or inspiration for your next Flutter + Flame game.

## 🧩 Case Studies / Examples

| # | Title | Description | Concepts Covered |
|---|-------|-------------|------------------|
| 1 | 🎮 Your First 2D Game | A simple interactive game where you can create and control squares with health bars | Game loop, component creation, tap detection, health system, rotation mechanics |
| 2 | 🕹️ Joystick Component | A spaceship control demo with joystick movement and shooting mechanics | Joystick controls, player movement, projectile system, audio integration |
| 3 | 💥 Collision Detection | An interactive demo where circles bounce off walls and each other | Collision detection, vector math, component interaction, screen boundaries |
| 4 | ⏱️ Timers and Collisions | Circles bouncing off walls and each other, losing 'life' over time/collisions | Timers (implicit), Collision Detection, Component Lifecycle, Basic Physics, Sound Effects |

## 🎯 Project Details

### Your First 2D Game
- Create squares by tapping on the screen
- Each square has a health bar and rotates continuously
- Tap on squares to change their direction and reduce health
- Double tap to pause/resume the game
- Includes a counter for active objects

### Joystick Component
- Control a spaceship using an on-screen joystick
- Shoot projectiles by tapping the screen
- Features smooth movement and rotation
- Includes sound effects for shooting
- Screen wrapping for continuous movement

### Collision Detection
- Tap to create bouncing circles
- Circles change color on collision
- Automatic wall bouncing mechanics
- Clean physics-based movement
- Visual feedback for collisions

## 🚀 Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/flutter-flame-case-studies.git
   ```
2. Navigate to any case study project:
   ```bash
   cd collision_detection
   # or
   cd joystick_component
   # or
   cd your_first_2d_game
   ```
3. Run the app:
   ```bash
   flutter pub get
   flutter run
   ```

## 📦 Requirements
- Flutter (Latest stable version)
- Dart SDK
- Flame Engine (^1.27.0)
- Android Studio / VS Code / Any Flutter-supported IDE

## 🎮 Controls
- **Your First 2D Game**: Tap to create squares, tap squares to interact, double tap to pause
- **Joystick Component**: Use on-screen joystick to move, tap to shoot
- **Collision Detection**: Tap anywhere to create bouncing circles

## 🛠️ Technical Features
- Component-based architecture
- Vector-based movement and physics
- Health/Life bar system
- Sound effect integration
- Collision detection and response
- Touch input handling
- Game state management
