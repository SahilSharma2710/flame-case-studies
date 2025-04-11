import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

import 'utils.dart';

/// Solution to case-study #1 exercises #1
///
/// The Utils.generateRandomPosition ansd Utils.generateRandomVelocity is the
/// solution ot exercise #1
void main() {
  YourFirst2DGame myGame = YourFirst2DGame();
  runApp(
    GameWidget(
      game: myGame,
    ),
  );
}

/// Simple component shape example of a square component
///
class Square extends PositionComponent {
  //
  // default values
  //

  // velocity is 0 here
  var velocity = Vector2(0, 0).normalized() * 25;
  // large square
  var squareSize = 128.0;
  // colored white with no-fill and an outline strike
  var color = BasicPalette.white.paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;

  @override
  //
  // initialize the component
  Future<void> onLoad() async {
    super.onLoad();
    size.setValues(squareSize, squareSize);
    anchor = Anchor.topRight;
  }

  @override
  //
  // update the inner state of the shape
  // in our case the position based on velocity
  void update(double dt) {
    super.update(dt);
    // speed is refresh frequency independent
    position += velocity * dt;
  }

  @override
  //
  // render the shape
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), color);
  }
}

/// The game class
///
/// Our main class which drives the Square generation code based on user
/// tapping on the screen
///
/// This is solution code to case-Study #1 - Exercise #1
class YourFirst2DGame extends FlameGame with DoubleTapDetector, TapCallbacks {
  bool running = true;
  Vector2 margins = Vector2(15, 15);

  @override
  //
  //
  // Process user's single tap (tap up)
  void onTapUp(TapUpEvent event) {
    // location of user's tap
    final touchPoint = event.canvasPosition;

    //
    // handle the tap action
    //
    // check if the tap location is within any of the shapes on the screen
    // and if so remove the shape from the screen
    final handled = children.any((component) {
      if (component is Square && component.containsPoint(touchPoint)) {
        // remove(component);
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
        ..position = Utils.generateRandomPosition(size, margins)
        ..squareSize = 45.0
        ..velocity = Utils.generateRandomVelocity(size, 25, 100)
        ..color = (BasicPalette.red.paint()
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
}
