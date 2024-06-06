import 'package:flamegame/actors/actor.dart';

class Enemy extends Actor{

  Enemy({
    required super.actor,
    required super.character,
    super.speed = 30,
    super.position
  });

  @override
  void update(double dt) {
    super.update(dt);

    if(isMoving) {
      switch (direction) {
        case ActorDirection.down:
          animation = walkDownAnimation;
          break;
        case ActorDirection.left:
          animation = walkLeftAnimation;
          break;
        case ActorDirection.up:
          animation = walkUpAnimation;
          break;
        case ActorDirection.right:
          animation = walkRightAnimation;
          break;
      }
    } else {
      switch (direction) {
        case ActorDirection.down:
          animation = idleDownAnimation;
          break;
        case ActorDirection.left:
          animation = idleLeftAnimation;
          break;
        case ActorDirection.up:
          animation = idleUpAnimation;
          break;
        case ActorDirection.right:
          animation = idleRightAnimation;
          break;
      }
    }

    final displacement = directionVector.normalized() * speed * dt;
    position.add(displacement);
  }

  void moveUp() {
    direction = ActorDirection.up;
    directionVector.y = -speed;
    state = ActorState.walk;
    isMoving = true;
  }

  void moveDown() {
    direction = ActorDirection.down;
    directionVector.y = speed;
    state = ActorState.walk;
    isMoving = true;
  }

  void moveLeft() {
    direction = ActorDirection.left;
    directionVector.x = -speed;
    state = ActorState.walk;
    isMoving = true;
  }

  void moveRight() {
    direction = ActorDirection.right;
    directionVector.x = speed;
    state = ActorState.walk;
    isMoving = true;
  }
}