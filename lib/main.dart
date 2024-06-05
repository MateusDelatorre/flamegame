import 'package:flamegame/levels/tiny_game.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final game = TinyGame();
  runApp(
      GameWidget(
        game: game
      ));
}
