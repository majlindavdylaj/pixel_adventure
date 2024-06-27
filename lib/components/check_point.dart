import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

class CheckPoint extends SpriteAnimationComponent
    with HasGameRef<PixelAdventure>, CollisionCallbacks {
  CheckPoint({super.position, super.size});

  bool flagShowing = false;

  @override
  FutureOr<void> onLoad() {
    priority = -1;
    add(RectangleHitbox(
        position: Vector2(12, 35),
        size: Vector2(12, 12),
        collisionType: CollisionType.passive));
    animation = SpriteAnimation.fromFrameData(
        game.images
            .fromCache('Items/Checkpoints/Checkpoint/Checkpoint (No Flag).png'),
        SpriteAnimationData.sequenced(
            amount: 1, stepTime: 1, textureSize: Vector2.all(64)));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (game.areFruitsCollected && !flagShowing) {
      _reachedCheckPoint();
      flagShowing = true;
    }
    super.update(dt);
  }

  void _reachedCheckPoint() async {
    animation = SpriteAnimation.fromFrameData(
        game.images.fromCache(
            'Items/Checkpoints/Checkpoint/Checkpoint (Flag Out) (64x64).png'),
        SpriteAnimationData.sequenced(
            amount: 26,
            stepTime: 0.05,
            textureSize: Vector2.all(64),
            loop: false));

    await animationTicker!.completed;

    animation = SpriteAnimation.fromFrameData(
        game.images.fromCache(
            'Items/Checkpoints/Checkpoint/Checkpoint (Flag Idle)(64x64).png'),
        SpriteAnimationData.sequenced(
            amount: 10, stepTime: 0.05, textureSize: Vector2.all(64)));
  }
}
