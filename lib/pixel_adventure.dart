import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_new/levels/level.dart';

class PixelAdventure extends FlameGame {
  @override
  Color backgroundColor() => const Color(0xFF211F30);

  late final CameraComponent cam;
  final worldd = Level();
  @override
  FutureOr<void> onLoad() {
    cam = CameraComponent.withFixedResolution(
      width: 640,
      height: 360,
      world: worldd,
    );
    cam.viewfinder.anchor = Anchor.topLeft;
    addAll([cam, worldd]);
    return super.onLoad();
  }
}
