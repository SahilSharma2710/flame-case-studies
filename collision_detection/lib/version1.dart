import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

///
/// This solution provides an algorithm for correct bouncing off the edge of
/// the wall so that the ball bascially can bounce around inside the screen
/// boundaries
class CirclesV1 extends FlameGame with HasCollisionDetection, TapCallbacks {
  @override
  bool debugMode = false;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(ScreenHitbox());
  }

  @override
  void onTapDown(TapDownEvent event) {
    add(MyCollidableV1(event.canvasPosition));
  }
}

class MyCollidableV1 extends CircleComponent
    with HasGameRef<CirclesV1>, CollisionCallbacks {
  late Vector2 velocity;
  final _collisionColor = Colors.amber;
  final _defaultColor = Colors.cyan;
  Color _currentColor = Colors.cyan;
  bool _isWallHit = false;
  bool _isCollision = false;
  final double _speed = 200;

  int xDirection = 1;
  int yDirection = 1;

  MyCollidableV1(Vector2 position)
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

    final rect = toRect();

    if ((rect.left <= 0 && xDirection == -1) ||
        (rect.right >= gameRef.size.x && xDirection == 1)) {
      xDirection = xDirection * -1;
    }

    if ((rect.top <= 0 && yDirection == -1) ||
        (rect.bottom >= gameRef.size.y && yDirection == 1)) {
      yDirection = yDirection * -1;
    }

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
    paint = Paint()..color = _currentColor;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is ScreenHitbox && !_isWallHit) {
      _isWallHit = true;
      return;
    }
    if (other is MyCollidableV1) {
      _isCollision = true;
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is MyCollidableV1) {
      xDirection = xDirection * -1;
      yDirection = yDirection * -1;
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}
