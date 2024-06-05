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
  }
}