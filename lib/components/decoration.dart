import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flamegame/levels/tiny_game.dart';

class Decoration extends SpriteComponent with HasGameRef<TinyGame> {
  Decoration({
    position,
    required this.name,
    super.size,
  });

  final String name;

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('objects/$name.png');

    return super.onLoad();
  }
}