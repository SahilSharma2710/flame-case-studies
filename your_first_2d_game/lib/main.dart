import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:your_first_2d_game/utils.dart';

import 'lifebar.dart';

void main() {
  YourFirst2DGame myGame = YourFirst2DGame();
  runApp(
    GameWidget(
      game: myGame,
    ),
  );
}

//
//
// Simple component shape example of a square component
class Square extends PositionComponent with HasGameRef<YourFirst2DGame> {
  // default values
  //
  var velocity = Vector2(0, 25);
  var rotationSpeed = 0.3;
  var squareSize = 128.0;
  var color = Paint()
    ..color = Colors.orange
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;
  late LifeBar lifeBar;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    size.setValues(squareSize, squareSize);
    anchor = Anchor.center;
    createLifeBar();
  }

  @override
  //
  // render the shape
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), color);
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
    angle = (angle + angleDelta) % (2 * pi);

    if (Utils.isPositionOutOfBounds(gameRef.size, position)) {
      gameRef.remove(this);
    }
  }

  //
  //
  // Create a rudimentary lifebar shape
  createLifeBar() {
    lifeBar = LifeBar.initData(size,
        size: Vector2(size.x - 10, 5), placement: LifeBarPlacement.center);
    //
    // add all lifebar element to the children of the Square instance
    add(lifeBar);
  }

  /// Method for communicating life state information to the class object
  ///
  processHit() {
    lifeBar.decrementCurrentLifeBy(20);
  }
}

//
//
// The game class
class YourFirst2DGame extends FlameGame with DoubleTapDetector, TapCallbacks {
  static const description = '''
        Creation of a square component which is spawned when user taps on the screen.
        If the user taps on any shape again it will change direction. Shapes go out of the screen but
        continue to exist in the program and we have a couter of all shapes spawned.
        Additionally have the square shape moving at constant speed with constant angular momentum.
        We add a child shape to the square to simulate a health bar. This bar also moves with the 
        square and with a set opacity.
      ''';

  //
  // controls if the engine is paused or not
  bool running = true;
  @override
  // runnig in debug mode
  bool debugMode = false;
  //
  // text rendering const
  final TextPaint textPaint = TextPaint(
    style: const TextStyle(
      fontSize: 14.0,
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

    //
    // handle the tap action
    //
    // check if the tap location is within any of the shapes on the screen
    // and if so remove the shape from the screen
    final handled = children.any((component) {
      if (component is Square && component.containsPoint(touchPoint)) {
        // remove(component);
        component.processHit();
        component.velocity.negate();
        return true;
      }
      return false;
    });

    //
    // this is a clean location with no shapes
    // create and add a new shape to the component tree under the FlameGame
    if (!handled) {
      add(Square()
        ..position = touchPoint
        ..squareSize = 75.0
        ..velocity = Vector2(0, 1).normalized() * 50
        ..color = (Paint()
          ..color = Colors.red
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2));
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
        canvas, "objects active: ${children.length - 3}", Vector2(10, 20));
    super.render(canvas);
  }
}
