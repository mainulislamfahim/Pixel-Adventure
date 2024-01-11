import 'dart:async';
import 'dart:ui';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/rendering.dart';
import 'package:pixel_adventure/models/actors.dart';
import 'package:pixel_adventure/models/level.dart';

class PixelAdventure extends FlameGame
    with HasKeyboardHandlerComponents, DragCallbacks {
  @override
  Color backgroundColor() => const Color(0xFF211F30);
  Actors actor = Actors(character: 'Mask Dude');
  late JoystickComponent joystick;
  late final CameraComponent cam;
  bool showJoystick = true;
  @override
  void render(Canvas canvas) {
    super.render(canvas); // Render other components first

    if (cam != null) {
      joystick.render(canvas);
    } // Render joystick on top
  }

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();
    final world = Level(levelName: 'Level-01', actors: actor);
    cam = CameraComponent.withFixedResolution(
        world: world, width: 582, height: 360);
    cam.viewfinder.anchor = Anchor.topLeft;

    addAll([cam, world]);

    if (showJoystick) {
      addJoyStick();
    }

    return super.onLoad();
  }

  @override
  void update(double dt) {
    updateJoystick();
    super.update(dt);
  }

  void addJoyStick() {
    joystick = JoystickComponent(
      knob: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/knob.png'),
        ),
      ),
      knobRadius: 20,
      background: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/joyStick.png'),
        ),
      ),
      margin: const EdgeInsets.only(left: 30, bottom: 42),
    );
    // joystick.priority = 10;
    add(joystick);
  }

  void updateJoystick() {
    switch (joystick.direction) {
      case JoystickDirection.left:
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
        actor.playerDirection = PlayerDirection.left;
        break;
      case JoystickDirection.right:
      case JoystickDirection.downRight:
      case JoystickDirection.upRight:
        actor.playerDirection = PlayerDirection.right;
        break;
      default:
        actor.playerDirection = PlayerDirection.none;
        break;
    }
  }
}
