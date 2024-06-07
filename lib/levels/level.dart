import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flamegame/actors/enemies/enemy.dart';
import 'package:flamegame/actors/npc/npc.dart';
import 'package:flamegame/actors/player/player.dart';
import 'package:flamegame/components/decoration.dart';

class Level extends World{

  Level({required this.levelName, required this.player});

  final String levelName;
  final Player player;
  late TiledComponent map;
  List<PositionComponent> collisionBlocks = [];

  @override
  FutureOr<void> onLoad() async {
    map = await TiledComponent.load('$levelName.tmx', Vector2(15, 15));
    add(map);
    spawnEntities();
    addCollisions();

    return super.onLoad();
  }

  spawnEntities(){
    final spawnPointsLayer = map.tileMap.getLayer<ObjectGroup>('spawnpoints');

    if (spawnPointsLayer != null) {
      for (final spawnPoint in spawnPointsLayer.objects) {
        switch (spawnPoint.class_) {
          case 'goblin':
            final Enemy goblin = Enemy(character: 'goblin', actor: 'enemy');
            goblin.position = Vector2(spawnPoint.x, spawnPoint.y);
            goblin.scale.x = 1;
            add(goblin);
            break;
          case 'skeleton':
            final Enemy skeleton = Enemy(character: 'skeleton', actor: 'enemy');
            skeleton.position = Vector2(spawnPoint.x, spawnPoint.y);
            skeleton.scale.x = 1;
            add(skeleton);
            break;
          case 'player':
            player.character = 'Char2';
            player.position = Vector2(spawnPoint.x, spawnPoint.y);
            player.scale.x = 1;
            add(player);
            break;
          case 'laila':
            final Npc laila = Npc(character: 'laila', actor: 'npc', size: Vector2(16, 19));
            laila.position = Vector2(spawnPoint.x, spawnPoint.y);
            laila.scale.x = 1;
            add(laila);
            break;
          case 'calvo':
            final Npc calvo = Npc(character: 'calvo', actor: 'npc');
            calvo.position = Vector2(spawnPoint.x, spawnPoint.y);
            calvo.scale.x = 1;
            add(calvo);
            break;
          case 'tree':
            final Decoration decoration = Decoration(name: 'tree', size: Vector2(48, 54));
            decoration.position = Vector2(spawnPoint.x, spawnPoint.y);
            add(decoration);
            break;
          case 'bridge_side':
            final Decoration decoration = Decoration(name: 'bridge_side', size: Vector2(8, 16));
            decoration.position = Vector2(spawnPoint.x, spawnPoint.y);
            add(decoration);
            break;
          case 'bridge_vertical':
            final Decoration decoration = Decoration(name: 'bridge_vertical', size: Vector2(16, 8));
            decoration.position = Vector2(spawnPoint.x, spawnPoint.y);
            add(decoration);
            break;
          case 'bush':
            final Decoration decoration = Decoration(name: 'bush', size: Vector2(15, 13));
            decoration.position = Vector2(spawnPoint.x, spawnPoint.y);
            add(decoration);
            break;
          case 'chest':
            final Decoration decoration = Decoration(name: 'chest', size: Vector2(48, 54));
            decoration.position = Vector2(spawnPoint.x, spawnPoint.y);
            add(decoration);
            break;
          case 'flower_blue':
            final Decoration decoration = Decoration(name: 'flower_blue', size: Vector2(16, 16));
            decoration.position = Vector2(spawnPoint.x, spawnPoint.y);
            add(decoration);
            break;
          case 'flower_orange':
            final Decoration decoration = Decoration(name: 'flower_orange', size: Vector2(16, 16));
            decoration.position = Vector2(spawnPoint.x, spawnPoint.y);
            add(decoration);
            break;
          case 'flower_pink':
            final Decoration decoration = Decoration(name: 'flower_pink', size: Vector2(16, 16));
            decoration.position = Vector2(spawnPoint.x, spawnPoint.y);
            add(decoration);
            break;
          case 'pole':
            final Decoration decoration = Decoration(name: 'pole', size: Vector2(16, 16));
            decoration.position = Vector2(spawnPoint.x, spawnPoint.y);
            add(decoration);
            break;
          case 'rock':
            final Decoration decoration = Decoration(name: 'rock', size: Vector2(15, 15));
            decoration.position = Vector2(spawnPoint.x, spawnPoint.y);
            add(decoration);
            break;
          case 'rock2':
            final Decoration decoration = Decoration(name: 'rock2', size: Vector2(14, 8));
            decoration.position = Vector2(spawnPoint.x, spawnPoint.y);
            add(decoration);
            break;
          case 'shop':
            final Decoration decoration = Decoration(name: 'shop', size: Vector2(48, 14));
            decoration.position = Vector2(spawnPoint.x, spawnPoint.y);
            add(decoration);
            break;
          case 'sign':
            final Decoration decoration = Decoration(name: 'sign', size: Vector2(16, 16));
            decoration.position = Vector2(spawnPoint.x, spawnPoint.y);
            add(decoration);
            break;
          default:
        }
      }
    }
  }

  void addCollisions() {
    final collisionsLayer = map.tileMap.getLayer<ObjectGroup>('collisions');

    if (collisionsLayer != null) {
      for (final collision in collisionsLayer.objects) {
        final block = PositionComponent(
          position: Vector2(collision.x, collision.y),
          size: Vector2(collision.width, collision.height),
        );
        collisionBlocks.add(block);
        add(block);
      }
    }
    //player.collisionBlocks = collisionBlocks;
  }
}