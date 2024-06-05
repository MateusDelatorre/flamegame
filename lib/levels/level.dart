import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flamegame/actors/player/player.dart';

class Level extends World{

  Level({required this.levelName, required this.player});

  final String levelName;
  final Player player;
  late TiledComponent map;

  @override
  FutureOr<void> onLoad() async {
    map = await TiledComponent.load('$levelName.tmx', Vector2(16, 16));
    add(map);

    _spawnEntities();

    return super.onLoad();
  }

  _spawnEntities(){
    final spawnPointsLayer = map.tileMap.getLayer<ObjectGroup>('spawnpoints');

    if (spawnPointsLayer != null) {
      for (final spawnPoint in spawnPointsLayer.objects) {
        switch (spawnPoint.class_) {
          case 'player':
            player.character = 'Char1';
            player.position = Vector2(spawnPoint.x, spawnPoint.y);
            player.scale.x = 1;
            add(player);
            break;
          default:
        }
      }
    }
  }
/*
  void _addCollisions() {
    final collisionsLayer = level.tileMap.getLayer<ObjectGroup>('Collisions');

    if (collisionsLayer != null) {
      for (final collision in collisionsLayer.objects) {
        switch (collision.class_) {
          case 'Platform':
            final platform = CollisionBlock(
              position: Vector2(collision.x, collision.y),
              size: Vector2(collision.width, collision.height),
              isPlatform: true,
            );
            collisionBlocks.add(platform);
            add(platform);
            break;
          default:
            final block = CollisionBlock(
              position: Vector2(collision.x, collision.y),
              size: Vector2(collision.width, collision.height),
            );
            collisionBlocks.add(block);
            add(block);
        }
      }
    }
    player.collisionBlocks = collisionBlocks;
  }
}*/

}