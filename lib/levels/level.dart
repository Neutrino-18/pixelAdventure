import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_new/actors/player.dart';
import 'package:flame_tiled/flame_tiled.dart';

class Level extends World {
  late TiledComponent level;
  final Player player = Player();
  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load('Level-01.tmx', Vector2.all(16));
    add(level);
    add(player);

    return super.onLoad();
  }
}
