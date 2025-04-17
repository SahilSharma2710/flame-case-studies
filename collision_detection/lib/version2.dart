import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class CirclesV2 extends FlameGame with HasCollisionDetection, TapCallbacks {
  @override
  bool debugMode = false;
  int _ballCounter = 0;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(ScreenHitbox());
  }

  @override
  void onTapDown(TapDownEvent event) {
    add(MyCollidableV2(event.canvasPosition, _ballCounter % 3));
    _ballCounter++;
  }
}

class MyCollidableV2 extends CircleComponent
    with HasGameRef<CirclesV2>, CollisionCallbacks {
  late Vector2 velocity;
  final double _speed = 200;
  int ballType; // 0 = red, 1 = blue, 2 = green
  bool _isWallHit = false;

  static const List<Color> ballColors = [
    Colors.red,
    Colors.lightBlueAccent,
    Colors.green,
  ];

  int xDirection = 1;
  int yDirection = 1;

  MyCollidableV2(Vector2 position, this.ballType)
      : super(
          position: position,
          radius: 10,
          anchor: Anchor.center,
        ) {
    add(CircleHitbox());
    paint = Paint()..color = ballColors[ballType];
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

    if (_isWallHit) {
      _isWallHit = false;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is ScreenHitbox && !_isWallHit) {
      _isWallHit = true;
      return;
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is MyCollidableV2) {
      // Handle color transfer
      if ((ballType == 0 && other.ballType == 1) || // red hits blue
          (ballType == 1 && other.ballType == 2) || // blue hits green
          (ballType == 2 && other.ballType == 0)) {
        // green hits red
        other.ballType = ballType;
        other.paint = Paint()..color = ballColors[ballType];
      }

      xDirection = xDirection * -1;
      yDirection = yDirection * -1;
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}
