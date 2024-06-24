import 'package:pixel_adventure/components/collision_block.dart';
import 'package:pixel_adventure/components/player.dart';

bool checkCollision(Player player, CollisionBlock block) {
  final hitBox = player.hitBox;
  final playerX = player.position.x + hitBox.offsetX;
  final playerY = player.position.y + hitBox.offsetY;
  final playerWidth = hitBox.width;
  final playerHeight = hitBox.height;

  final blockX = block.x;
  final blockY = block.y;
  final blockWidth = block.width;
  final blockHeight = block.height;

  final fixedX = player.scale.x < 0
      ? playerX - (hitBox.offsetX * 2) - playerWidth
      : playerX;
  final fixedY = block.isPlatform ? playerY + playerHeight : playerY;

  return (fixedY < blockY + blockHeight &&
      playerY + playerHeight > blockY &&
      fixedX < blockX + blockWidth &&
      fixedX + playerWidth > blockX);
}
