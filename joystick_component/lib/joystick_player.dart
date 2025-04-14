import 'package:flame/components.dart';

class JoystickPlayer extends SpriteComponent with HasGameRef {
  /// Max speed in Pixels/s
  double maxSpeed = 300.0;

  //
  // this gives the player component access to the Joystick data
  final JoystickComponent joystick;

  //
  // constructor which aggregates the Joystick access
  JoystickPlayer(this.joystick)
      : super(
          size: Vector2.all(50.0),
        ) {
    anchor = Anchor.center;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    //
    // ship png comes from Kenny
    // https://www.kenney.nl/assets
    //
    sprite = await gameRef.loadSprite('asteroids_ship.png');
    position = gameRef.size / 2;
  }

  @override
  void update(double dt) {
    //
    // if the joystick has moved
    if (!joystick.delta.isZero()) {
      print("joystick.relativeDelta: ${joystick.relativeDelta}");
      print("joystick.delta: ${joystick.delta}");
      position.add(joystick.relativeDelta * maxSpeed * dt);
      angle = joystick.delta.screenAngle();
    }
  }
}
