import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flamegame/levels/tiny_game.dart';

enum ActorState {
  idle,
  walk
}

enum ActorDirection {
  down,
  left,
  up,
  right
}

class Actor extends SpriteAnimationComponent with HasGameRef<TinyGame>, CollisionCallbacks{

  Actor({
    position,
    size,
    required this.character,
    required this.actor,
    this.speed = 30,
  }) : super(size: size ?? Vector2(16, 16));

  String character;
  String actor;
  ActorDirection direction = ActorDirection.down;
  ActorState state = ActorState.idle;
  final Vector2 directionVector = Vector2.zero();
  final double speed;
  bool isMoving = false;

  // Player Animations
  final double _animationSpeed = 0.20;
  late SpriteAnimation idleDownAnimation;
  late SpriteAnimation idleLeftAnimation;
  late SpriteAnimation idleUpAnimation;
  late SpriteAnimation idleRightAnimation;

  late SpriteAnimation walkDownAnimation;
  late SpriteAnimation walkLeftAnimation;
  late SpriteAnimation walkUpAnimation;
  late SpriteAnimation walkRightAnimation;

  @override
  Future<void> onLoad() async {

    loadAnimations();
    add(RectangleHitbox());

    return super.onLoad();
  }

  loadAnimations(){
    // idle
    SpriteSheet spriteSheet = SpriteSheet(
      image: game.images.fromCache('$actor/$character/idle_16px.png'),
      srcSize: Vector2(16, 16),
    );
    idleDownAnimation = spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 4);
    idleLeftAnimation = spriteSheet.createAnimation(row: 1, stepTime: _animationSpeed, to: 4);
    idleUpAnimation = spriteSheet.createAnimation(row: 2, stepTime: _animationSpeed, to: 4);
    idleRightAnimation = spriteSheet.createAnimation(row: 3, stepTime: _animationSpeed, to: 4);

    // walk
    spriteSheet = SpriteSheet(
      image: game.images.fromCache('$actor/$character/walk_16px.png'),
      srcSize: Vector2(16, 16),
    );
    walkDownAnimation = spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 4);
    walkLeftAnimation = spriteSheet.createAnimation(row: 1, stepTime: _animationSpeed, to: 4);
    walkUpAnimation = spriteSheet.createAnimation(row: 2, stepTime: _animationSpeed, to: 4);
    walkRightAnimation = spriteSheet.createAnimation(row: 3, stepTime: _animationSpeed, to: 4);

    animation = idleDownAnimation;
  }

  SpriteAnimation spriteAnimation(String state, int amountPerRow, int amount) {
    //print('player/$character/${state}_16px.png');
    return SpriteAnimation.fromFrameData(
      game.images.fromCache('$actor/$character/${state}_16px.png'),
      SpriteAnimationData.sequenced(
        amount: amount,
        amountPerRow: amountPerRow,
        stepTime: _animationSpeed,
        textureSize: size,
      ),
    );
  }

  SpriteAnimation specialSpriteAnimation(String state, int amount) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache('$actor/$character/${state}_32.png'),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: _animationSpeed,
        textureSize: Vector2.all(32),
        loop: false,
      ),
    );
  }
}
