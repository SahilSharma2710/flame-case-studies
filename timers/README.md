# 🔥 Timers and Collisions Case Study

This project demonstrates collision detection and basic object lifecycle management using timers (implicitly via a life value decrementing over time) within the Flame engine.

## 🧩 Concepts Covered

- Collision Detection (Object-Object and Object-Wall)
- Component Lifecycle Management (adding/removing components based on state)
- Basic Physics (velocity, direction changes)
- Sound Effects on Collision
- Health/Life Representation
- Touch Input Handling (implicit via game setup, though not directly interactive in the provided code)

## 🎯 Project Details

- Circles are created with initial positions and velocities.
- Circles bounce off the screen boundaries.
- Circles bounce off each other when they collide.
- Each collision (wall or other circle) reduces the circle's 'life'.
- A text component displays the remaining life of each circle.
- Circles are removed from the game when their life reaches zero.
- Sound effects play when circles collide with each other.

## 🚀 Getting Started

1. Ensure you are in the main `flame-case-studies` directory.
2. Navigate to this project:
   ```bash
   cd timers
   ```
3. Run the app:
   ```bash
   flutter pub get
   flutter run
   ```

## 🎮 Controls

- This example is primarily observational. Circles are added programmatically and interact automatically.

## 🛠️ Technical Features

- Uses Flame's `CollisionCallbacks` and `CircleHitbox`.
- Implements vector-based movement.
- Manages object state (life value) and removes components dynamically.
- Integrates `flame_audio` for sound effects.
- Displays dynamic text information using `TextComponent`.
