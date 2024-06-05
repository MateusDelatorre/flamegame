import 'package:flame/components.dart';

enum ActorState {
  fall,
  hit,
  idle,
  idleSwim,
  pickItem,
  pull,
  push,
  roll,
  swim,
  walk
}

enum ActorDirection {
  down,
  left,
  up,
  right
}

mixin Actor {
}
