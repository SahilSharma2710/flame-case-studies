import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

import 'utils.dart';

//
//
// Bullet class is a PositionComponent so we get the angle and position of the
// element.
class Bullet extends PositionComponent with HasGameRef {
  // color of the bullet
  static final _paint = Paint()..color = Colors.white;
  // the bullet speed in pixles per second
  final double _speed = 150;
  // velocity vector for the bullet.
  late Vector2 _velocity;
  late final Vector2 _bounds;

  //
  // default constructor with default values
  Bullet(Vector2 position, Vector2 velocity, Vector2 bounds)
      : _velocity = velocity,
        _bounds = bounds,
        super(
          position: position,
          size: Vector2.all(4), // 4x4 bullet
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // _velocity is a unit vector so we need to make it account for the actual
    // speed.
    _velocity = (_velocity)..scaleTo(_speed);
    // sounds used for the shot
    FlameAudio.play('missile_shot.wav');
    // layered sounds for missile transition/flyby
    FlameAudio.play('missile_flyby.wav');
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), _paint);
  }

  @override
  void update(double dt) {
    position.add(_velocity * dt);
    if (Utils.isPositionOutOfBounds(_bounds, position)) {
      removeFromParent();
      FlameAudio.play('missile_hit.wav');
    }
  }
}
