import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_new/pixel_adventure.dart';

class Fruit extends SpriteAnimationComponent with HasGameRef<PixelAdventure> {
  final String fruit;

  Fruit({this.fruit = 'Apple', super.position, super.size});

  final double stepTIme = 0.1;

  @override
  FutureOr<void> onLoad() {
    priority = -1;
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
}
