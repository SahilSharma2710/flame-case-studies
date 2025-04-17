import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart' hide Image, Draggable;

const myCollidablesInfo = '''
This example will create a circle every time you tap on the screen. It will have
the initial velocity towards the center of the screen and if it touches another
circle both of them will change color.
''';

main() {
  final myGame = Circles();
  runApp(
    GameWidget(
      game: myGame,
    ),
  );
}

/// Solution to case-study #4 exercise #1
///
/// This solution provides an algorithm for correct bouncing off the edge of
/// the wall so that the ball bascially can bounce around inside the screen
/// boundaries
class Circles extends FlameGame with HasCollisionDetection, TapCallbacks {
  @override
  bool debugMode = false;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    /// Add screen boundaries as a collidable
    /// - currently unsued in this version of code
    add(ScreenHitbox());
  }

  @override
  void onTapDown(TapDownEvent event) {
    /// add a new 'ball' to the screen in the tap position
    add(MyCollidable(event.canvasPosition));
  }
}

class MyCollidable extends CircleComponent
    with HasGameRef<Circles>, CollisionCallbacks {
  late Vector2 velocity;
  final _collisionColor = Colors.amber;
  final _defaultColor = Colors.cyan;
  Color _currentColor = Colors.cyan;
  bool _isWallHit = false;
  bool _isCollision = false;
  final double _speed = 200;

  /// direction vector split into constituetn x and y elements
  /// we start with the vector (1, 1) which is pointing down
  /// and to the right
  int xDirection = 1;
  int yDirection = 1;

  MyCollidable(Vector2 position)
      : super(
          position: position,
          radius: 10,
          anchor: Anchor.center,
        ) {
    add(CircleHitbox());
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final center = gameRef.size / 2;
    velocity = (center - position)..scaleTo(_speed);
  }

  @override
  void update(double dt) {
    super.update(dt);

    x += xDirection * _speed * dt;
    y += yDirection * _speed * dt;

    /// get the bounding rectangle for our 'ball' object
    final rect = toRect();

    /// check for collision between the ball and the screen boundaries
    /// by testing each  component of the direction vector's x and y
    ///
    ///

    /// check if we passed the left or right screen edge
    ///
    if ((rect.left <= 0 && xDirection == -1) ||
        (rect.right >= gameRef.size.x && xDirection == 1)) {
      /// reverse direction
      xDirection = xDirection * -1;
    }

    /// check if we passed the top or bottom screen edge
    ///
    if ((rect.top <= 0 && yDirection == -1) ||
        (rect.bottom >= gameRef.size.y && yDirection == 1)) {
      /// reverse direction
      yDirection = yDirection * -1;
      //print('rect size: $rect screen size: ${gameRef.size}');
    }

    /// test for collision color to show collision between balls
    _currentColor = _isCollision ? _collisionColor : _defaultColor;
    if (_isCollision) {
      _isCollision = false;
    }
    if (_isWallHit) {
      _isWallHit = false;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // renderHitboxes(canvas);
    paint = Paint()..color = _currentColor;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is ScreenHitbox && !_isWallHit) {
      _isWallHit = true;
      return;
    }
    if (other is MyCollidable) {
      _isCollision = true;
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is MyCollidable) {
      xDirection = xDirection * -1;
      yDirection = yDirection * -1;
    }

    super.onCollisionStart(intersectionPoints, other);
  }
}
