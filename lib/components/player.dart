import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_new/components/collision_block.dart';
import 'package:flame_new/constants.dart';
import 'package:flame_new/pixel_adventure.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/src/services/hardware_keyboard.dart';
// import 'package:flutter/src/services/keyboard_key.g.dart';

enum PlayerState { idle, running }

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<PixelAdventure>, KeyboardHandler {
  final String character;
  Player({super.position, this.character = ninjaFrog});
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runningAnimation;
  final double idleTime = 0.05;
  double horizontalMovement = 0;
  List<CollisionBlock> collisionBlocks = [];

  double moveSpeed = 150;
  Vector2 velocity = Vector2.zero();
  @override
  FutureOr<void> onLoad() {
    debugMode = true;
    _loadAllAnimations();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _checkHorizontalCollisions();
    _updatePlayerState();
    _updatePlayerMovement(dt);
    super.update(dt);
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    horizontalMovement = 0;

    final isLeftKeyPressed =
        keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final isRightKeyPressed =
        keysPressed.contains(LogicalKeyboardKey.keyD) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight);

    horizontalMovement += isLeftKeyPressed ? -1 : 0;
    horizontalMovement += isRightKeyPressed ? 1 : 0;

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

  void _updatePlayerState() {
    PlayerState playerState = PlayerState.idle;
    if (velocity.x < 0 && scale.x > 0) {
      flipHorizontallyAroundCenter();
    } else if (velocity.x > 0 && scale.x < 0) {
      flipHorizontallyAroundCenter();
    }

    //check if moving, set running
    if (velocity.x > 0 || velocity.x < 0) {
      playerState = PlayerState.running;
    }
    current = playerState;
  }

  void _updatePlayerMovement(double dt) {
    velocity.x = horizontalMovement * moveSpeed;
    position.x += velocity.x * dt;
  }

  void _checkHorizontalCollisions() {}
}
