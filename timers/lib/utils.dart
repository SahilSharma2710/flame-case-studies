import 'dart:math';

import 'package:flame/components.dart';

/// Generalized utility methods for Vector based problems.
///
///
class Utils {
  /// Generate a random location for any Component
  ///
  ///
  static Vector2 generateRandomPosition(Vector2 screenSize, Vector2 margins) {
    var result = Vector2.zero();
    var randomGenerator = Random();
    //
    // Generate a new random position
    result = Vector2(
        randomGenerator
                .nextInt(screenSize.x.toInt() - 2 * margins.x.toInt())
                .toDouble() +
            margins.x,
        randomGenerator
                .nextInt(screenSize.y.toInt() - 2 * margins.y.toInt())
                .toDouble() +
            margins.y);

    return result;
  }

  /// Generate a random direction and velocity for any Component
  ///
  /// This creates a directional vector that is randmized over a unit circle
  /// the [min] and [max] are used to create a range for the actual speed
  /// component of the vector
  static Vector2 generateRandomVelocity(Vector2 screenSize, int min, int max) {
    var result = Vector2.zero();
    var randomGenerator = Random();
    double velocity;

    while (result == Vector2.zero()) {
      result = Vector2(
          (randomGenerator.nextInt(3) - 1) * randomGenerator.nextDouble(),
          (randomGenerator.nextInt(3) - 1) * randomGenerator.nextDouble());
    }
    result.normalize();
    velocity = (randomGenerator.nextInt(max - min) + min).toDouble();

    // print('random velocity $velocity');
    // print('random direction vector $result');
    return result * velocity;
  }

  /// Generate a random direction for a component
  ///
  /// This creates a directional vector that is randmized over a unit circle
  static Vector2 generateRandomDirection() {
    var result = Vector2.zero();
    var randomGenerator = Random();

    while (result == Vector2.zero()) {
      result = Vector2(
          (randomGenerator.nextInt(3) - 1), (randomGenerator.nextInt(3) - 1));
    }

    //result.normalized();
    //print('random direction vector $result');
    return result;
  }

  /// Generate a random speed for any Component
  ///
  /// This creates a speed value.
  /// the [min] and [max] are used to create a range for the actual speed
  /// component of the vector
  static double generateRandomSpeed(int min, int max) {
    var randomGenerator = Random();
    double speed;

    speed = (randomGenerator.nextInt(max - min) + min).toDouble();

    // print('random velocity $velocity');
    // print('random direction vector $result');
    return speed;
  }

  /// Check if the given [position] is out of bounds of the passed in
  /// [bounds] object usually represneting a screen size or some bounding
  /// area
  ///
  static bool isPositionOutOfBounds(Vector2 bounds, Vector2 position) {
    bool result = false;

    if (position.x >= bounds.x ||
        position.x <= 0 ||
        position.y <= 0 ||
        position.y >= bounds.y) {
      result = true;
    }

    return result;
  }
}
