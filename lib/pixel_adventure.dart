import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:pixel_adventure/levels/level.dart';

class PixelAdventure extends FlameGame with HasKeyboardHandlerComponents {

  @override
  Color backgroundColor() => const Color(0xFF211F30);
  late final CameraComponent cam;

  final level = Level(
    levelName: 'Level-01'
  );

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();

    cam = CameraComponent.withFixedResolution(world: level, width: 640, height: 360);
    cam.viewfinder.anchor = Anchor.topLeft;

    addAll([level, cam]);
    return super.onLoad();
  }

}