import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:pixel_adventure/components/player.dart';
import 'package:pixel_adventure/components/level.dart';

class PixelAdventure extends FlameGame
    with HasKeyboardHandlerComponents, DragCallbacks, HasCollisionDetection {
  @override
  Color backgroundColor() => const Color(0xFF211F30);
  late CameraComponent cam;
  Player player = Player(character: 'Mask Dude');
  late JoystickComponent joystick;
  bool showJoystick = false;
  List<String> levelNames = ['level-01', 'level-02'];
  int currentLevelIndex = 0;

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();
    _loadLevel();
    if (showJoystick) {
      addJoyStick();
    }

    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (showJoystick) {
      updateJoystick();
    }
    super.update(dt);
  }

  void addJoyStick() {
    joystick = JoystickComponent(
        priority: 2,
        knob: SpriteComponent(sprite: Sprite(images.fromCache('HUD/Knob.png'))),
        background: SpriteComponent(
            sprite: Sprite(images.fromCache('HUD/Joystick.png'))),
        margin: const EdgeInsets.only(left: 32, bottom: 32));
    add(joystick);
  }

  void updateJoystick() {
    switch (joystick.direction) {
      case JoystickDirection.downLeft:
      case JoystickDirection.upLeft:
      case JoystickDirection.left:
        player.horizontalMovement = -1;
        break;
      case JoystickDirection.downRight:
      case JoystickDirection.upRight:
      case JoystickDirection.right:
        player.horizontalMovement = 1;
        break;
      default:
        player.horizontalMovement = 0;
        break;
    }
  }

  void loadNextLevel() {
    removeWhere((component) => component is Level);
    if(currentLevelIndex < levelNames.length - 1){
      currentLevelIndex++;
      Future.delayed(const Duration(seconds: 1), (){
        _loadLevel();
      });
    } else {
      //No more levels
    }
  }

  void _loadLevel() {
    Level level = Level(levelName: levelNames[currentLevelIndex], player: player);

    cam = CameraComponent.withFixedResolution(
        world: level, width: 640, height: 360);
    cam.viewfinder.anchor = Anchor.topLeft;
    cam.priority = 1;

    addAll([level, cam]);
  }
}
