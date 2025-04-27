import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/cupertino.dart';

class StarParallaxExample extends FlameGame {
  static const String description = '''
    Shows the simplest way to use a top-down fullscreen `ParallaxComponent`.
  ''';

  final _imageNames = [
    ParallaxImageData('small_stars.png'),
    ParallaxImageData('big_stars.png'),
  ];

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final parallax = await loadParallaxComponent(_imageNames,
        baseVelocity: Vector2(0, -10),
        velocityMultiplierDelta: Vector2(1.0, 1.8),
        repeat: ImageRepeat.repeat);
    add(parallax);
  }
}
