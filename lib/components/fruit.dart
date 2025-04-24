import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_new/pixel_adventure.dart';

class Fruit extends SpriteAnimationComponent with HasGameRef<PixelAdventure> {
  final String fruit;

  Fruit({this.fruit = 'Apple', super.position, super.size});

  final double stepTIme = 0.5;

  @override
  FutureOr<void> onLoad() {
    return super.onLoad();
  }
}
