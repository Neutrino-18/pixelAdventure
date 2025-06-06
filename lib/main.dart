import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_new/pixel_adventure.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Flame.device.fullScreen();
  await Flame.device.setLandscape();
  final game = PixelAdventure();
  runApp(GameWidget(game: kDebugMode ? PixelAdventure() : game));
}
