import 'dart:async';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flamegame/levels/level.dart';

class PhaseOne extends FlameGame {

  late final CameraComponent cam;

  @override
  FutureOr<void> onLoad() {
    world = Level();
    cam = CameraComponent(world: world);
    cam.viewfinder.anchor = Anchor.topLeft;
    addAll([
      cam,
      world,
    ]);
    return super.onLoad();
  }
}