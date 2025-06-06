import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_new/components/custom_hitbox.dart';
import 'package:flame_new/pixel_adventure.dart';

class Fruit extends SpriteAnimationComponent
    with HasGameRef<PixelAdventure>, CollisionCallbacks {
  final String fruit;

  Fruit({
    this.fruit = 'Apple',
    super.position,
    super.size,
    super.removeOnFinish = true,
  });

  final double stepTIme = 0.05;
  bool _collected = false;
  final hitbox = CustomHitbox(offSetX: 10, offSetY: 10, width: 12, height: 12);

  @override
  FutureOr<void> onLoad() {
    // priority shows where the component is located the complete so called "3d-plane" of the 2d scene.
    priority = -1;

    add(
      RectangleHitbox(
        position: Vector2(hitbox.offSetX, hitbox.offSetY),
        size: Vector2(hitbox.width, hitbox.height),
        collisionType: CollisionType.passive,
      ),
    );
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('Items/Fruits/$fruit.png'),
      SpriteAnimationData.sequenced(
        amount: 17,
        stepTime: stepTIme,
        textureSize: Vector2.all(32),
      ),
    );
    return super.onLoad();
  }

  void collidedWithPlayer() {
    if (!_collected) {
      animation = SpriteAnimation.fromFrameData(
        game.images.fromCache('Items/Fruits/Collected.png'),
        SpriteAnimationData.sequenced(
          amount: 17,
          stepTime: stepTIme,
          textureSize: Vector2.all(32),
          loop: false,
        ),
      );
      _collected = true;
    }
  }
}
