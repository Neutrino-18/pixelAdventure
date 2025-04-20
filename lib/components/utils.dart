bool checkCollision(player, block) {
  final hitbox = player.hitbox;
  final playerX = player.position.x + hitbox.offSetX;
  final playerY = player.position.y + hitbox.offSetY;
  final playerWidth = hitbox.width;
  final playerHeight = hitbox.height;

  final blockX = block.x;
  final blockY = block.y;
  final blockWidth = block.width;
  final blockHeight = block.height;

  /* fixing the x an y because, when the player's direction(scale) changes, the coordinates also changes and hence the player collision happens with the other side of player rather than the expected side */

  final fixedX =
      player.scale.x < 0
          ? playerX - (hitbox.offSetX * 2) - playerWidth
          : playerX;
  final fixedY = block.isPlatform ? playerY + playerHeight : playerY;
  // returning true when the player's dimensions exceeds(is same as) the dimensions of block otherwise false
  return (fixedY < blockY + blockHeight &&
      playerY + playerHeight > blockY &&
      fixedX < blockX + blockWidth &&
      fixedX + playerWidth > blockX);
}
