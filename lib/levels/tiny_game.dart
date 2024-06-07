import 'dart:async';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flamegame/actors/player/player.dart';
import 'package:flamegame/levels/level.dart';

class TinyGame extends FlameGame with
    HasKeyboardHandlerComponents,
    DragCallbacks,
    HasCollisionDetection,
    TapCallbacks{

  late CameraComponent cam;

  @override
  FutureOr<void> onLoad() async {
    debugMode = true;
    await _loadAllImages();
    Level world = Level(levelName: 'map1', player: Player());

    cam = CameraComponent.withFixedResolution(
      world: world,
      width: 640,
      height: 360,
    );
    cam.viewfinder.anchor = Anchor.topLeft;
    addAll([
      cam,
      world
    ]);

    return super.onLoad();
  }

  _loadAllImages() async {
    await images.load('enemy/goblin/bow_16px.png');
    await images.load('enemy/goblin/idle_16px.png');
    await images.load('enemy/goblin/walk_16px.png');
    await images.load('enemy/skeleton/idle_16px.png');
    await images.load('enemy/skeleton/walk_16px.png');

    await images.load('player/Char1/fall_16px.png');
    await images.load('player/Char1/hit_16px.png');
    await images.load('player/Char1/idle_16px.png');
    await images.load('player/Char1/idle_swim_16px.png');
    await images.load('player/Char1/pick_item_16px.png');
    await images.load('player/Char1/pull_16px.png');
    await images.load('player/Char1/push_16px.png');
    await images.load('player/Char1/roll_16px.png');
    await images.load('player/Char1/swim_16px.png');
    await images.load('player/Char1/walk_16px.png');

    await images.load('player/Char2/fall_16px.png');
    await images.load('player/Char2/hit_16px.png');
    await images.load('player/Char2/idle_16px.png');
    await images.load('player/Char2/idle_swim_16px.png');
    await images.load('player/Char2/pick_item_16px.png');
    await images.load('player/Char2/pull_16px.png');
    await images.load('player/Char2/push_16px.png');
    await images.load('player/Char2/roll_16px.png');
    await images.load('player/Char2/swim_16px.png');
    await images.load('player/Char2/walk_16px.png');


    await images.load('npc/laila/idle_16px.png');
    await images.load('npc/calvo/idle_16px.png');

    await images.load('objects/bridge_side.png');
    await images.load('objects/bridge_vertical.png');
    await images.load('objects/bush.png');
    await images.load('objects/chest.png');
    await images.load('objects/flower_blue.png');
    await images.load('objects/flower_orange.png');
    await images.load('objects/flower_pink.png');
    await images.load('objects/pole.png');
    await images.load('objects/quest_exclamation.png');
    await images.load('objects/rock.png');
    await images.load('objects/rock2.png');
    await images.load('objects/shop.png');
    await images.load('objects/sign.png');
    await images.load('objects/tree.png');
  }
}