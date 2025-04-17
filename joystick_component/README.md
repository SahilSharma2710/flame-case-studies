# 🕹️ Joystick Component Demo

A Flutter Flame example demonstrating joystick controls with a space shooter mechanic.

## 🎮 Features

- **Joystick Control**: Smooth spaceship movement using on-screen joystick
- **Shooting Mechanics**: Tap to fire projectiles
- **Sound Effects**:
  - Missile shot sounds
  - Missile flyby effects
  - Impact sounds
- **Screen Wrapping**: Ship wraps around screen edges for continuous movement
- **Dynamic Movement**: 
  - Responsive controls
  - Rotation based on movement direction
  - Variable speed control

## 🎯 How to Play

1. Use the joystick in the bottom-left corner to control the spaceship
2. Tap anywhere on the screen to shoot projectiles
3. Navigate around the screen freely
4. Experiment with different movement patterns and shooting angles

## 🔧 Technical Implementation

- Uses `FlameGame` with `TapCallbacks`
- Custom components:
  - `JoystickPlayer`: Handles player movement and rotation
  - `Bullet`: Manages projectile behavior
  - `JoystickComponent`: Controls input handling
- Features:
  - Vector-based movement
  - Screen wrapping logic
  - Audio integration
  - Component-based architecture

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
- Flame Audio ^2.11.3

## 🎵 Assets Required

Place the following audio files in the `assets/audio/` directory:
- `missile_shot.wav`
- `missile_flyby.wav`
- `missile_hit.wav`
- `race_to_mars.mp3` (background music)

Place sprite images in the `assets/images/` directory:
- `asteroids_ship.png`