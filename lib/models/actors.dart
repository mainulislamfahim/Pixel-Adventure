import 'dart:async';

import 'package:flame/components.dart';
import 'package:pixel_adventure/views/pixel_adventure.dart';

enum PlayerState { idle, running }

class Actors extends SpriteAnimationGroupComponent
    with HasGameRef<PixelAdventure> {
  Actors({position, required this.character}) : super(position: position);
  String character;
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runingAnimation;

  final double stepTime = 0.05;
  @override
  FutureOr<void> onLoad() {
    _loadAnimations();
    return super.onLoad();
  }

  void _loadAnimations() {
    idleAnimation = _spriteAnimation('Idle', 11);

    runingAnimation = _spriteAnimation('Run', 12);
    //list of all animations
    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.running: runingAnimation
    };
    //set current animation
    current = PlayerState.idle;
  }

  SpriteAnimation _spriteAnimation(String state, int amount) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache('Main Characters/$character/$state (32x32).png'),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: stepTime,
        textureSize: Vector2.all(32),
      ),
    );
  }
}
