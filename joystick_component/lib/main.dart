import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/cupertino.dart';

import 'bullet.dart';
import 'joystick_player.dart';

main() {
  final example = JoystickExample();
  runApp(
    GameWidget(game: example),
  );
}

class JoystickExample extends FlameGame with TapCallbacks {
  static const String description = '''
    In this example we showcase how to use the joystick by creating simple
    `CircleComponent`s that serve as the joystick's knob and background.
    Steer the player by using the joystick. We also show how to shoot bullets
    and how to find the angle of the bullet path relative to the ship's angle
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
    final knobPaint = BasicPalette.gray.withAlpha(500).paint();
    final backgroundPaint = BasicPalette.cyan.withAlpha(50).paint();
    //
    // Actual Joystick component creation
    joystick = JoystickComponent(
      knob: CircleComponent(radius: 15, paint: knobPaint),
      background: CircleComponent(radius: 50, paint: backgroundPaint),
      margin: const EdgeInsets.only(left: 20, bottom: 20),
    );

    //
    // adding the player that will be controlled by our joystick
    player = JoystickPlayer(joystick);

    //
    // add both joystick and the controlled player to the game instance
    add(player);
    add(joystick);
    // addBackgroundMusic();
  }

  @override
  void update(double dt) {
    //
    //  show the angle of the player
    print("current children: ${children.length - 3}");
    super.update(dt);
  }

  @override
  //
  //
  // We will handle the tap action by the user to shoot a bullet
  // each time the user taps and lifts their finger
  void onTapUp(TapUpEvent event) {
    //
    // velocity vector pointing straight up.
    // Represents 0 radians which is 0 desgrees
    var velocity = Vector2(0, -1);
    // rotate this vector to the same ange as the player
    velocity.rotate(player.angle);
    // create a bullet with the specific angle and add it to the game
    add(Bullet(player.position, velocity, size));
    super.onTapUp(event);
  }

  void addBackgroundMusic() {
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play('race_to_mars.mp3');
  }
}
