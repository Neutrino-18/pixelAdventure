import 'package:flame/components.dart';

class CollisionBlock extends PositionComponent {
  bool isPlatform;
  CollisionBlock({this.isPlatform = false, super.position, super.size}) {
    debugMode = true;
  }
}
