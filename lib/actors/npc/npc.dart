import 'package:flamegame/actors/actor.dart';

class Npc extends Actor{

  Npc({
    super.position,
    super.size,
    required super.actor,
    required super.character,
    super.speed = 0,
  });

  @override
  void loadAnimations(){
    idleDownAnimation = spriteAnimation("idle", 4, 4);
    animation = idleDownAnimation;
  }
}