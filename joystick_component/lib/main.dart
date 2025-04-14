import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/cupertino.dart';

import 'joystick_player.dart';

main() {
  final example = JoystickExample();
  runApp(
    GameWidget(game: example),
  );
}

class JoystickExample extends FlameGame {
  static const String description = '''
    In this example we showcase how to use the joystick by creating two simple
    `CircleComponent` instances that serve as the joystick's knob and 
    background. Steer the player by using the joystick.
  ''';

  //
  // The player being controlled by Joystick
  late final JoystickPlayer player;
  //
  // The actual Joystick component
  late final JoystickComponent joystick;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    //
    // joystick knob and background skin styles
    final knobPaint = BasicPalette.gray.withAlpha(200).paint();
    final backgroundPaint = BasicPalette.cyan.withAlpha(50).paint();
    //
    // Actual Joystick component creation
    joystick = JoystickComponent(
      knob: CircleComponent(radius: 15, paint: knobPaint),
      background: CircleComponent(radius: 50, paint: backgroundPaint),
      // screen position margin
      margin: const EdgeInsets.only(left: 20, bottom: 20),
    );
    //
    // adding the player that will be controlled by our joystick
    player = JoystickPlayer(joystick);

    //
    // add both joystick and the controlled player to the game instance
    add(player);
    add(joystick);
  }

  @override
  void update(double dt) {
    //
    //  show the angle of the player
    print("current player angle: ${player.angle}");
    super.update(dt);
  }
}
