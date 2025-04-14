import 'package:flame/components.dart';

/// Generalized utility methods for Vector based problems.
///
///
class Utils {
  /// Check if the given [position] is out of bounds of the passed in
  /// [bounds] object usually representing a screen size or some bounding
  /// area
  ///
  static bool isPositionOutOfBounds(Vector2 bounds, Vector2 position) {
    bool result = false;

    if (position.x > bounds.x ||
        position.x < 0 ||
        position.y < 0 ||
        position.y > bounds.y) {
      result = true;
    }

    return result;
  }

  /// Calculate the wrapped position for any objects based on the input of
  /// the [bounds] which is the fencing around some area like the screen, and
  /// the [position] that we would like to wrap around that fencing.
  ///
  /// 'Wrapping' in this context means simply translating the position that is
  /// moving out of bounds to wrap around the edges to come out on the other
  /// end with teh same speed and directionality.
  ///
  /// Note that it the position does not need to be wrapped then original
  /// [position] is returned.
  static Vector2 wrapPosition(Vector2 bounds, Vector2 position) {
    Vector2 result = position;

    if (position.x >= bounds.x) {
      result.x = 0;
    } else if (position.x <= 0) {
      result.x = bounds.x;
    }

    if (position.y >= bounds.y) {
      result.y = 0;
    } else if (position.y <= 0) {
      result.y = bounds.y;
    }

    return result;
  }
}
