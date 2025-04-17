# 💥 Collision Detection Demo

A Flutter Flame example showcasing collision detection between multiple objects and screen boundaries.

## 🎮 Features

- **Dynamic Circle Creation**: Tap anywhere on the screen to create bouncing circles
- **Collision Detection**: Circles detect and respond to collisions with:
  - Other circles (changes color and direction)
  - Screen boundaries (bounces off walls)
- **Visual Feedback**: Color changes from cyan to amber on collision
- **Physics-Based Movement**: 
  - Constant velocity movement
  - Direction changes on collision
  - Screen boundary containment

## 🎯 How to Play

1. Tap anywhere on the screen to create a circle
2. Each circle will move towards the center of the screen initially
3. Watch circles bounce off walls and interact with each other
4. Create multiple circles to see complex interaction patterns

## 🔧 Technical Implementation

- Uses `FlameGame` with `HasCollisionDetection` and `TapCallbacks`
- Implements `CircleComponent` with `CollisionCallbacks`
- Features:
  - Vector-based movement
  - Screen boundary detection
  - Collision response system
  - Dynamic object creation
  - Visual state management

## 🚀 Getting Started

1. Ensure Flutter and Flame are properly installed
2. Run the following commands:
```bash
flutter pub get
flutter run
```

## 📦 Dependencies

- Flutter SDK
- Flame Engine ^1.27.0