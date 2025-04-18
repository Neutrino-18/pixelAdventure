import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_new/components/player.dart';
import 'package:flame_new/constants.dart';
import 'package:flame_new/components/level.dart';
import 'package:flutter/painting.dart';

class PixelAdventure extends FlameGame
    with HasKeyboardHandlerComponents, DragCallbacks {
  @override
  Color backgroundColor() => const Color(0xFF211F30);

  late final CameraComponent cam;
  Player player = Player(character: maskDude);
  late JoystickComponent joystick;
  bool showJoystick = false;

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();
    final worldd = Level(levelName: level1, player: player);
    cam = CameraComponent.withFixedResolution(
      width: 650,
      height: 360,
      world: worldd,
    );
    cam.viewfinder.anchor = Anchor.topLeft;
    addAll([cam, worldd]);
    if (showJoystick) {
      addJoystick();
    }

    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (showJoystick) {
      updatejoystick();
    }
    super.update(dt);
  }

  void addJoystick() {
    joystick = JoystickComponent(
      knob: SpriteComponent(sprite: Sprite(images.fromCache('HUD/Knob.png'))),
      margin: EdgeInsets.only(left: 32, bottom: 32),
      background: SpriteComponent(
        sprite: Sprite(images.fromCache('HUD/JoyStick.png')),
      ),
    );
    add(joystick);
  }

  void updatejoystick() {
    switch (joystick.direction) {
      case JoystickDirection.left:
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
        // player.playerDirection = PlayerDirection.left;
        break;
      case JoystickDirection.right:
      case JoystickDirection.upRight:
      case JoystickDirection.downRight:
        // player.playerDirection = PlayerDirection.right;
        break;
      default:
      // player.playerDirection = PlayerDirection.none;
    }
  }
}
