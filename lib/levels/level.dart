import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

class Level extends World{

  late TiledComponent map;

  @override
  FutureOr<void> onLoad() async {
    map = await TiledComponent.load('level1.tmx', Vector2.all(16));
    add(map);
    return super.onLoad();
  }
}