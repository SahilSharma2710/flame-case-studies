# 🎮 Collision Detection Demo

A comprehensive Flutter Flame example demonstrating various collision detection techniques and game mechanics. This project serves as a learning resource for game development with Flutter and Flame engine.

| Version 1.0 | Version 2.0 | Version 3.0 |
|:-----------:|:-----------:|:-----------:|
| ![Basic Collision](https://github.com/user-attachments/assets/01ab4ef8-2cfd-498c-8e99-c997149f6c33) | ![Color Transfer](https://github.com/user-attachments/assets/059beebd-9858-4c42-b119-80fd825218dd) | ![Rock Paper Scissors](your_new_gif_url_here) |
| Basic Collisions | Color Transfer | Rock Paper Scissors Battle |

## 📚 Learning Objectives

- Understanding collision detection in Flame
- Implementing game physics and boundary detection
- Managing game state and component interactions
- Working with color systems and visual feedback
- Structuring game code for maintainability

## 🚀 Version History

### Version 1.0 - Basic Collision System

- **Features**:
  - Dynamic circle creation
  - Basic collision detection
  - Visual feedback system
  - Physics-based movement
- **Key Concepts**:

  ```dart
  // Basic collision detection
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is ScreenHitbox) {
      // Handle wall collision
    }
    if (other is MyCollidable) {
      // Handle ball collision
    }
  }
  ```

  ### Version 2.0 - Color Transfer Collision System

- **New Features**:
  - Sequential ball colors (Red → Blue → Green)
  - Color transfer on collision:
    - Red balls convert Blue balls
    - Blue balls convert Green balls
    - Green balls convert Red balls
  - Maintained physics and boundary collision system
- **Key Concepts**:

  ```dart
  // Ball type management using enums
  static const List<Color> ballColors = [
    Colors.red,
    Colors.lightBlueAccent,
    Colors.green,
  ];

  // Color transfer logic
  if ((ballType == 0 && other.ballType == 1) || // red hits blue
      (ballType == 1 && other.ballType == 2) || // blue hits green
      (ballType == 2 && other.ballType == 0)) { // green hits red
    other.ballType = ballType;
  }
  ```

### Version 3.0 - Rock Paper Scissors Battle

- **New Features**:
  - Sprite-based objects (Rock, Paper, Scissors)
  - Dynamic size system:
    - Random sizes between 32 and 80 pixels
    - Each spawn creates unique-sized sprites
  - Random sprite generation on tap
  - Battle system based on RPS rules:
    - Rock crushes Scissors
    - Scissors cuts Paper
    - Paper covers Rock
  - Victory effects:
    - Winner pulses with scale animation
    - Defeated sprite explodes into particles
    - Particle effects match defeated sprite's type

- **Key Concepts**:

  ```dart
  // Random size generation
  final randomSize = 32.0 + math.Random().nextDouble() * 48.0;
  size: Vector2.all(randomSize);

  // Sprite and type management
  enum SpriteType { rock, paper, scissors }

  // Battle resolution logic
  bool defeats(SpriteType other) {
    return (type == SpriteType.rock && other == SpriteType.scissors) ||
           (type == SpriteType.scissors && other == SpriteType.paper) ||
           (type == SpriteType.paper && other == SpriteType.rock);
  }

  // Victory effects
  add(
    ScaleEffect.by(
      Vector2.all(1.2),
      EffectController(
        duration: 0.2,
        reverseDuration: 0.2,
      ),
    ),
  );

  ```

## 🎮 How to Play

1. Tap anywhere on the screen to create circles
2. Each circle moves towards the screen center initially
3. Watch circles bounce off walls and interact with each other
4. Create multiple circles to see complex interaction patterns

## 🔧 Technical Implementation

### Core Flame Concepts Used

1. **Game Setup**

```dart
class Circles extends FlameGame with HasCollisionDetection, TapCallbacks {
  // HasCollisionDetection: Enables collision detection
  // TapCallbacks: Handles touch input
}
```

2. **Component System**

```dart
class MyCollidable extends CircleComponent with CollisionCallbacks {
  // CircleComponent: Base class for circular game objects
  // CollisionCallbacks: Handles collision events
}
```

3. **Collision Detection**

- Using `CircleHitbox` for efficient circular collision detection
- Implementing `onCollision` and `onCollisionStart` callbacks
- Screen boundary detection using `ScreenHitbox`

4. **Vector Mathematics**

```dart
// Movement using vector mathematics
Vector2 velocity;
x += xDirection * _speed * dt;
y += yDirection * _speed * dt;
```

### Project Structure

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

- Version 4.0: Add particle effects on collision
- Version 5.0: Add power-ups and special effects
