# 💥 Collision Detection Demo

A Flutter Flame example showcasing collision detection between multiple objects and screen boundaries.

## 🚀 Version History

### Version 2.0 - Color Transfer Collision System
- **New Features**:
  - Sequential ball colors (Red → Blue → Green)
  - Color transfer on collision:
    - Red balls convert Blue balls
    - Blue balls convert Green balls
    - Green balls convert Red balls
  - Maintained physics and boundary collision system
- **How to Play**:
  1. Tap to create balls in sequence (Red → Blue → Green)
  2. Watch colors transfer on collision
  3. Try to create chain reactions of color changes

### Version 1.0 - Basic Collision System
- **Features**:
  - Dynamic circle creation with tap
  - Basic collision detection:
    - Ball-to-ball collisions (color change feedback)
    - Screen boundary collisions
  - Visual feedback (Cyan → Amber on collision)
  - Physics-based movement

## 🎮 How to Play

1. Tap anywhere on the screen to create circles
2. Each circle moves towards the screen center initially
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

## 💡 Future Ideas
- Version 3.0: Add size-based interactions
- Version 4.0: Add particle effects on collision
- Version 5.0: Add power-ups and special effects