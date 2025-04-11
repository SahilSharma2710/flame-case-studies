import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

import 'utils.dart';

/// Solution to case-study #1 exercises #2 and #3
///
/// The Utils.isPositionOutOfBounds is the solution ot exercise #2
/// The Asteroid class is solution to exercise #3
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  YourFirst2DGame myGame = YourFirst2DGame();
  runApp(
    GameWidget(
      game: myGame,
    ),
  );
}

/// Polygon-based asteroid shape example
class Asteroid extends PositionComponent with HasGameRef<YourFirst2DGame> {
  // default values
  //

  /// Vertices for the asteroid
  final vertices = [
    Vector2(0.2, 0.8), // v1
    Vector2(-0.6, 0.6), // v2
    Vector2(-0.8, 0.2), // v3
    Vector2(-0.6, -0.4), // v4
    Vector2(-0.4, -0.8), // v5
    Vector2(0.0, -1.0), // v6
    Vector2(0.4, -0.6), // v7
    Vector2(0.8, -0.8), // v8
    Vector2(1.0, 0.0), // v9
    Vector2(0.4, 0.2), // v10
    Vector2(0.7, 0.6), // v1
  ];

  late PolygonComponent asteroid;

  var velocity = Vector2(0, 25);
  var rotationSpeed = 0.3;
  var paint = Paint()
    ..color = Colors.green
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;

  @override
  //
  // render the shape
  void render(Canvas canvas) {
    super.render(canvas);
    asteroid.render(canvas);
  }

  @override
  //
  // update the inner state of the shape
  // in our case the position
  void update(double dt) {
    super.update(dt);
    // speed is refresh frequency independent
    position += velocity * dt;
    // add rotational speed update as well
    var angleDelta = dt * rotationSpeed;
    angle = (angle - angleDelta) % (2 * pi);

    /// check if the object is out of bounds
    ///
    /// if it is out-of-bounds then remove it from the game engine
    /// note the usage of gameRef to get access to the game engine
    if (Utils.isPositionOutOfBounds(gameRef.size, position)) {
      gameRef.remove(this);
    }
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    asteroid = PolygonComponent.relative(vertices, // the vertices
        parentSize: size, // the actual size of the shape
        position: position, // the position on the screen
        paint: paint);
    anchor = Anchor.center;
  }
}

//
//
// The game class
class YourFirst2DGame extends FlameGame with DoubleTapDetector, TapCallbacks {
  //
  // controls if the engine is paused or not
  bool running = true;
  // runnig in debug mode
  @override
  bool debugMode = false;
  //
  // text rendering const
  final TextPaint textPaint = TextPaint(
    style: const TextStyle(
      fontSize: 16.0,
      fontFamily: 'Awesome Font',
    ),
  );

  @override
  //
  //
  // Process user's single tap (tap up)
  void onTapUp(TapUpEvent event) {
    // location of user's tap
    final touchPoint = event.canvasPosition;
    print("<user tap> touchpoint: $touchPoint");

    /// handle the tap action
    ///
    /// check if the Square object is out of bounds of the screen
    final handled = children.any((component) {
      if (component is Asteroid && component.containsPoint(touchPoint)) {
        component.velocity.negate();
        return true;
      }
      return false;
    });

    //
    // this is a clean location with no shapes
    // create and add a new shape to the component tree under the FlameGame
    if (!handled) {
      add(Asteroid()
        ..position = touchPoint
        ..size = Vector2(100, 100)
        ..velocity = Vector2(0, 1).normalized() * 25
        ..paint = (BasicPalette.white.paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1));
    }
  }

  @override
  void onDoubleTap() {
    if (running) {
      pauseEngine();
    } else {
      resumeEngine();
    }

    running = !running;
  }

  @override
  void render(Canvas canvas) {
    textPaint.render(
        canvas, "objects active: ${children.length - 3}", Vector2(20, 60));

    super.render(canvas);
  }
}
