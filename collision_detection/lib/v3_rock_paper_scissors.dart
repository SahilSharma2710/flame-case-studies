import 'dart:math' as math;
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/effects.dart';

enum SpriteType { rock, paper, scissors }

class RPSGame extends FlameGame with HasCollisionDetection, TapCallbacks {
  @override
  Future<void> onLoad() async {
    // Load sprite sheets
    await images.loadAll([
      'rock.png',
      'paper.png',
      'scissors.png',
    ]);
    add(ScreenHitbox());
  }

  @override
  void onTapDown(TapDownEvent event) {
    // Create random sprite
    final random = math.Random();
    final type = SpriteType.values[random.nextInt(3)];
    add(RPSSprite(event.canvasPosition, type));
  }
}

class RPSSprite extends SpriteComponent
    with CollisionCallbacks, HasGameRef<RPSGame> {
  final SpriteType type;
  final double _speed = 150;
  late Vector2 velocity;

  int xDirection = 1;
  int yDirection = 1;

  RPSSprite(Vector2 position, this.type)
      : super(
          position: position,
          size: Vector2.all(32.0 +
              math.Random().nextDouble() * 48.0), // 48 is the range (80-32)
          anchor: Anchor.center,
        ) {
    add(CircleHitbox());
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite('${type.name}.png');
    final center = gameRef.size / 2;
    velocity = (center - position)..scaleTo(_speed);
  }

  bool defeats(SpriteType other) {
    return (type == SpriteType.rock && other == SpriteType.scissors) ||
        (type == SpriteType.scissors && other == SpriteType.paper) ||
        (type == SpriteType.paper && other == SpriteType.rock);
  }

  void win(RPSSprite loser) {
    // Add victory effects
    add(
      ScaleEffect.by(
        Vector2.all(1.2),
        EffectController(
          duration: 0.2,
          reverseDuration: 0.2,
        ),
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    x += xDirection * _speed * dt;
    y += yDirection * _speed * dt;

    // Bounce off screen edges
    final rect = toRect();
    if ((rect.left <= 0 && xDirection == -1) ||
        (rect.right >= gameRef.size.x && xDirection == 1)) {
      xDirection = xDirection * -1;
    }

    if ((rect.top <= 0 && yDirection == -1) ||
        (rect.bottom >= gameRef.size.y && yDirection == 1)) {
      yDirection = yDirection * -1;
    }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is RPSSprite) {
      if (defeats(other.type)) {
        win(other);
        other.removeFromParent();
      }
      // Bounce off each other
      xDirection = xDirection * -1;
      yDirection = yDirection * -1;
    }
  }
}
