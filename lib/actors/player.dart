import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_new/constants/constants.dart';
import 'package:flame_new/pixel_adventure.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/src/services/hardware_keyboard.dart';
// import 'package:flutter/src/services/keyboard_key.g.dart';

enum PlayerState { idle, running }

enum PlayerDirection { left, right, none }

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<PixelAdventure>, KeyboardHandler {
  final String character;
  Player({super.position, this.character = ninjaFrog});
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runningAnimation;
  final double idleTime = 0.05;
  bool isfacingRight = true;

  PlayerDirection playerDirection = PlayerDirection.none;
  double moveSpeed = 100;
  Vector2 velocity = Vector2.zero();
  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _updatePlayerMovement(dt);
    super.update(dt);
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isLeftKeyPressed =
        keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final isRightKeyPressed =
        keysPressed.contains(LogicalKeyboardKey.keyD) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight);

    if (isLeftKeyPressed && isRightKeyPressed) {
      playerDirection = PlayerDirection.none;
    } else if (isLeftKeyPressed) {
      playerDirection = PlayerDirection.left;
    } else if (isRightKeyPressed) {
      playerDirection = PlayerDirection.right;
    } else {
      playerDirection = PlayerDirection.none;
    }
    return super.onKeyEvent(event, keysPressed);
  }

  void _loadAllAnimations() {
    idleAnimation = _spriteAnimation(state: "Idle", amount: 11);

    runningAnimation = _spriteAnimation(state: "Run", amount: 12);

    // List of all animations
    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.running: runningAnimation,
    };

    // Set current animation
    current = PlayerState.running;
  }

  SpriteAnimation _spriteAnimation({
    required String state,
    required int amount,
  }) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache('Main Characters/$character/$state (32x32).png'),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: idleTime,
        textureSize: Vector2.all(32),
      ),
    );
  }

  void _updatePlayerMovement(double dt) {
    double dirX = 0.0;
    switch (playerDirection) {
      case PlayerDirection.left:
        if (isfacingRight) {
          flipHorizontallyAroundCenter();
          isfacingRight = false;
        }
        dirX -= moveSpeed;
        current = PlayerState.running;
        break;
      case PlayerDirection.right:
        if (!isfacingRight) {
          flipHorizontallyAroundCenter();
          isfacingRight = true;
        }
        dirX += moveSpeed;
        current = PlayerState.running;
        break;
      default:
        current = PlayerState.idle;
    }

    velocity = Vector2(dirX, 0.0);
    position += velocity * dt;
  }
}
