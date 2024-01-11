import 'dart:async';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:pixel_adventure/models/actors.dart';

class Level extends World {
  final String levelName;
  final Actors actors;
  Level({required this.actors, required this.levelName});
  late TiledComponent level;
  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load(
      '$levelName.tmx',
      Vector2.all(16),
    );
    // print(levelName);

    add(level);
    final spawnPointsLayer = level.tileMap.getLayer<ObjectGroup>('Spawnpoints');

    for (final spawnPoint in spawnPointsLayer!.objects) {
      switch (spawnPoint.class_) {
        case 'Player':
          actors.position = Vector2(spawnPoint.x, spawnPoint.y);
          add(actors);
          break;
        default:
      }
    }

    return super.onLoad();
  }
}
