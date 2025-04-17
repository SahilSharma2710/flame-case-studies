import 'package:collision_detection/version1.dart';
import 'package:collision_detection/version2.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart' hide Image, Draggable;

const myCollidablesInfo = '''
This example will create a circle every time you tap on the screen. It will have
the initial velocity towards the center of the screen. Balls follow a red->blue->green
sequence and transfer their colors on collision.
''';

void main() {
  final bool useVersion2 = false;

  final myGame = useVersion2 ? CirclesV2() : CirclesV1();
  runApp(
    GameWidget(
      game: myGame,
    ),
  );
}
