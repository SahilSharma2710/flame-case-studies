# 🎮 Your First 2D Game

A Flutter Flame example showcasing basic game mechanics with interactive squares and health bars.

## 🎮 Features

- **Dynamic Object Creation**: Tap to create squares anywhere on screen
- **Health System**: Each square has a configurable health bar
- **Interactive Elements**:
  - Tap squares to change direction and reduce health
  - Double tap to pause/resume game
- **Visual Elements**:
  - Continuous rotation animation
  - Color-coded health bars
  - Object counter
- **Component Management**: Automatic cleanup of destroyed objects

## 🎯 How to Play

1. Tap anywhere on the screen to create a square
2. Each square will:
   - Move in a specific direction
   - Rotate continuously
   - Display a health bar
3. Tap existing squares to:
   - Change their direction
   - Reduce their health
4. Double tap the screen to pause/resume the game
5. Watch the object counter in the top-left corner

## 🔧 Technical Implementation

- Uses `FlameGame` with `DoubleTapDetector` and `TapCallbacks`
- Custom components:
  - `Square`: Main game object with movement and rotation
  - `LifeBar`: Configurable health bar system
- Features:
  - Vector-based movement
  - Component lifecycle management
  - State tracking
  - Visual feedback systems
  - Pause/resume functionality

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

## 🎨 Customization

The game includes several customizable elements:
- Square size and color
- Movement speed and direction
- Health bar appearance and position
- Warning thresholds for health
- Rotation speed