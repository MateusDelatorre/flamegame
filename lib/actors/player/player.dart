import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/sprite.dart';
import 'package:flamegame/actors/enemies/enemy.dart';
import 'package:flutter/services.dart';
import 'package:flamegame/actors/actor.dart';
import 'package:flamegame/levels/tiny_game.dart';
import 'package:flutter/widgets.dart';

enum PlayerState {
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

class Player extends SpriteAnimationComponent with HasGameRef<TinyGame>,
    KeyboardHandler, CollisionCallbacks {

  Player({
    position,
    this.character = 'Char1',
  }) : super(size: Vector2(16, 16));

  String character;
  ActorDirection direction = ActorDirection.down;
  PlayerState state = PlayerState.idle;
  final Vector2 _direction = Vector2.zero();
  final double speed = 60;
  bool _isMoving = false;
  double life = 100;
  bool canMove = true;
  bool isSwimming = false;
  bool isAnimationPlaying = false;

  // Player Animations
  final double _animationSpeed = 0.20;
  late final SpriteAnimation fallingAnimation;
  late final SpriteAnimation hitAnimation;

  late SpriteAnimation idleDownAnimation;
  late SpriteAnimation idleLeftAnimation;
  late SpriteAnimation idleUpAnimation;
  late SpriteAnimation idleRightAnimation;

  late SpriteAnimation idleSwimDownAnimation;
  late SpriteAnimation idleSwimLeftAnimation;
  late SpriteAnimation idleSwimUpAnimation;
  late SpriteAnimation idleSwimRightAnimation;

  late SpriteAnimation pickItemAnimation;

  late SpriteAnimation pullDownAnimation;
  late SpriteAnimation pullLeftAnimation;
  late SpriteAnimation pullUpAnimation;
  late SpriteAnimation pullRightAnimation;

  late SpriteAnimation pushDownAnimation;
  late SpriteAnimation pushLeftAnimation;
  late SpriteAnimation pushUpAnimation;
  late SpriteAnimation pushRightAnimation;

  late SpriteAnimation rollDownAnimation;
  late SpriteAnimation rollLeftAnimation;
  late SpriteAnimation rollUpAnimation;
  late SpriteAnimation rollRightAnimation;

  late SpriteAnimation swimDownAnimation;
  late SpriteAnimation swimLeftAnimation;
  late SpriteAnimation swimUpAnimation;
  late SpriteAnimation swimRightAnimation;

  late SpriteAnimation walkDownAnimation;
  late SpriteAnimation walkLeftAnimation;
  late SpriteAnimation walkUpAnimation;
  late SpriteAnimation walkRightAnimation;

  @override
  Future<void> onLoad() async {

    _loadAnimations();
    add(RectangleHitbox());

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if(_isMoving) {
      final displacement = _direction.normalized() * speed * dt;
      position.add(displacement);
    }else{
      setState();
    }
    setAnimation();
  }

  setState(){
    if(_direction.x == 0 && _direction.y == 0){
      if(canMove){
        state = PlayerState.idle;
      }
    }
  }

  setAnimation(){
    switch(state){
      case PlayerState.fall:
        animation = fallingAnimation;
        break;
      case PlayerState.hit:
        animation = hitAnimation;
        break;
      case PlayerState.idle:
        setAnimationDirection(idleDownAnimation, idleLeftAnimation, idleUpAnimation, idleRightAnimation);
        break;
      case PlayerState.idleSwim:
        setAnimationDirection(idleSwimDownAnimation, idleSwimLeftAnimation, idleSwimUpAnimation, idleSwimRightAnimation);
        break;
      case PlayerState.pickItem:
        animation = pickItemAnimation;
        break;
      case PlayerState.pull:
        setAnimationDirection(pullDownAnimation, pullLeftAnimation, pullUpAnimation, pullRightAnimation);
        break;
      case PlayerState.push:
        setAnimationDirection(pushDownAnimation, pushLeftAnimation, pushUpAnimation, pushRightAnimation);
        break;
      case PlayerState.roll:
        setAnimationDirection(rollDownAnimation, rollLeftAnimation, rollUpAnimation, rollRightAnimation);
        break;
      case PlayerState.swim:
        setAnimationDirection(swimDownAnimation, swimLeftAnimation, swimUpAnimation, swimRightAnimation);
        break;
      case PlayerState.walk:
        setAnimationDirection(walkDownAnimation, walkLeftAnimation, walkUpAnimation, walkRightAnimation);
        break;
    }
  }

  setAnimationDirection(
      SpriteAnimation downAnimation,
      SpriteAnimation leftAnimation,
      SpriteAnimation upAnimation,
      SpriteAnimation rightAnimation
      ){
    switch (direction) {
      case ActorDirection.down:
        animation = downAnimation;
        break;
      case ActorDirection.left:
        animation = leftAnimation;
        break;
      case ActorDirection.up:
        animation = upAnimation;
        break;
      case ActorDirection.right:
        animation = rightAnimation;
        break;
    }
  }

  @override
  bool onKeyEvent(
      KeyEvent event,
      Set<LogicalKeyboardKey> keysPressed,
      ) {

    _isMoving = false;
    _direction.x = 0;
    _direction.y = 0;

    if(!canMove) return super.onKeyEvent(event, keysPressed);

    for (var element in keysPressed) {
      if(element == LogicalKeyboardKey.keyA) moveLeft();
      if(element == LogicalKeyboardKey.keyD) moveRight();
      if(element == LogicalKeyboardKey.keyW) moveUp();
      if(element == LogicalKeyboardKey.keyS) moveDown();
    }

    return super.onKeyEvent(event, keysPressed);
  }

  void moveUp() {
    direction = ActorDirection.up;
    _direction.y = -speed;
    state = PlayerState.walk;
    _isMoving = true;
  }

  void moveDown() {
    direction = ActorDirection.down;
    _direction.y = speed;
    state = PlayerState.walk;
    _isMoving = true;
  }

  void moveLeft() {
    direction = ActorDirection.left;
    _direction.x = -speed;
    state = PlayerState.walk;
    _isMoving = true;
  }

  void moveRight() {
    direction = ActorDirection.right;
    _direction.x = speed;
    state = PlayerState.walk;
    _isMoving = true;
  }


  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    _isMoving = false;
    if(other is Actor) {
      if(other is Enemy) {

        state = PlayerState.hit;
        if(other.position.x > position.x) {
          canMove = false;
          add(MoveByEffect(
            Vector2(-20, 0),
            EffectController(duration: 0.2),
            onComplete: () {
              canMove = true;
            },
          ));
        } else {
          canMove = false;
          add(MoveByEffect(
            Vector2(20, 0),
            EffectController(duration: 0.2),
            onComplete: () {
              canMove = true;
            },
          ));
        }
        if(other.position.y > position.y) {
          canMove = false;
          add(MoveByEffect(
            Vector2(0, -20),
            EffectController(duration: 0.2),
            onComplete: () {
              canMove = true;
            },
          ));
        } else {
          canMove = false;
          add(MoveByEffect(
            Vector2(0, 20),
            EffectController(duration: 0.2),
            onComplete: () {
              canMove = true;
            },
          ));
        }
        life -= 10;
      }
    super.onCollision(intersectionPoints, other);
    }
  }

  detectCollisionDirection(){

  }

  _loadAnimations(){
    fallingAnimation = _spriteAnimation('fall', 4, 4);
    hitAnimation = _spriteAnimation('hit', 4, 4);
    //pickItemAnimation = _spriteAnimation('pick_item', 1, 1);

    // idle
    SpriteSheet spriteSheet = SpriteSheet(
      image: game.images.fromCache('player/$character/idle_16px.png'),
      srcSize: Vector2(16, 16),
    );
    idleDownAnimation = spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 4);
    idleLeftAnimation = spriteSheet.createAnimation(row: 1, stepTime: _animationSpeed, to: 4);
    idleUpAnimation = spriteSheet.createAnimation(row: 2, stepTime: _animationSpeed, to: 4);
    idleRightAnimation = spriteSheet.createAnimation(row: 3, stepTime: _animationSpeed, to: 4);

    // idle_swim
    spriteSheet = SpriteSheet(
      image: game.images.fromCache('player/$character/idle_swim_16px.png'),
      srcSize: Vector2(16, 16),
    );
    idleSwimDownAnimation = spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 4);
    idleSwimLeftAnimation = spriteSheet.createAnimation(row: 1, stepTime: _animationSpeed, to: 4);
    idleSwimUpAnimation = spriteSheet.createAnimation(row: 2, stepTime: _animationSpeed, to: 4);
    idleSwimRightAnimation = spriteSheet.createAnimation(row: 3, stepTime: _animationSpeed, to: 4);

    // pull
    spriteSheet = SpriteSheet(
      image: game.images.fromCache('player/$character/pull_16px.png'),
      srcSize: Vector2(16, 16),
    );
    pullDownAnimation = spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 4);
    pullLeftAnimation = spriteSheet.createAnimation(row: 1, stepTime: _animationSpeed, to: 4);
    pullUpAnimation = spriteSheet.createAnimation(row: 2, stepTime: _animationSpeed, to: 4);
    pullRightAnimation = spriteSheet.createAnimation(row: 3, stepTime: _animationSpeed, to: 4);

    // push
    spriteSheet = SpriteSheet(
      image: game.images.fromCache('player/$character/push_16px.png'),
      srcSize: Vector2(16, 16),
    );
    pushDownAnimation = spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 4);
    pushLeftAnimation = spriteSheet.createAnimation(row: 1, stepTime: _animationSpeed, to: 4);
    pushUpAnimation = spriteSheet.createAnimation(row: 2, stepTime: _animationSpeed, to: 4);
    pushRightAnimation = spriteSheet.createAnimation(row: 3, stepTime: _animationSpeed, to: 4);

    // roll
    spriteSheet = SpriteSheet(
      image: game.images.fromCache('player/$character/roll_16px.png'),
      srcSize: Vector2(16, 16),
    );
    rollDownAnimation = spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 4);
    rollLeftAnimation = spriteSheet.createAnimation(row: 1, stepTime: _animationSpeed, to: 4);
    rollUpAnimation = spriteSheet.createAnimation(row: 2, stepTime: _animationSpeed, to: 4);
    rollRightAnimation = spriteSheet.createAnimation(row: 3, stepTime: _animationSpeed, to: 4);

    // swim
    spriteSheet = SpriteSheet(
      image: game.images.fromCache('player/$character/swim_16px.png'),
      srcSize: Vector2(16, 16),
    );
    swimDownAnimation = spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 4);
    swimLeftAnimation = spriteSheet.createAnimation(row: 1, stepTime: _animationSpeed, to: 4);
    swimUpAnimation = spriteSheet.createAnimation(row: 2, stepTime: _animationSpeed, to: 4);
    swimRightAnimation = spriteSheet.createAnimation(row: 3, stepTime: _animationSpeed, to: 4);

    // walk
    spriteSheet = SpriteSheet(
      image: game.images.fromCache('player/$character/walk_16px.png'),
      srcSize: Vector2(16, 16),
    );
    walkDownAnimation = spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 4);
    walkLeftAnimation = spriteSheet.createAnimation(row: 1, stepTime: _animationSpeed, to: 4);
    walkUpAnimation = spriteSheet.createAnimation(row: 2, stepTime: _animationSpeed, to: 4);
    walkRightAnimation = spriteSheet.createAnimation(row: 3, stepTime: _animationSpeed, to: 4);

    /*
    _spriteFromSheet(idleDownAnimation, idleLeftAnimation, idleUpAnimation, idleRightAnimation, 'idle');
    _spriteFromSheet(idleSwimDownAnimation, idleSwimLeftAnimation, idleSwimUpAnimation, idleSwimRightAnimation, 'idle_swim');
    _spriteFromSheet(pullDownAnimation, pullLeftAnimation, pullUpAnimation, pullRightAnimation, 'pull');
    _spriteFromSheet(pushDownAnimation, pushLeftAnimation, pushUpAnimation, pushRightAnimation, 'push');
    _spriteFromSheet(rollDownAnimation, rollLeftAnimation, rollUpAnimation, rollRightAnimation, 'roll');
    _spriteFromSheet(swimDownAnimation, swimLeftAnimation, swimUpAnimation, swimRightAnimation, 'swim');
    _spriteFromSheet(walkDownAnimation, walkLeftAnimation, walkUpAnimation, walkRightAnimation, 'walk');
     */

    animation = idleLeftAnimation;
  }

  _spriteFromSheet(
      SpriteAnimation downAnimation,
      SpriteAnimation leftAnimation,
      SpriteAnimation upAnimation,
      SpriteAnimation rightAnimation,
      String state
      ) async {

    SpriteSheet spriteSheet;
    spriteSheet = SpriteSheet(
      image: game.images.fromCache('player/$character/${state}_16px.png'),
      srcSize: Vector2(16, 16),
    );

    downAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 4);

    leftAnimation =
        spriteSheet.createAnimation(row: 1, stepTime: _animationSpeed, to: 4);

    upAnimation =
        spriteSheet.createAnimation(row: 2, stepTime: _animationSpeed, to: 4);

    rightAnimation =
        spriteSheet.createAnimation(row: 3, stepTime: _animationSpeed, to: 4);
  }

  SpriteAnimation _spriteAnimation(String state, int amountPerRow, int amount) {
    //print('player/$character/${state}_16px.png');
    return SpriteAnimation.fromFrameData(
      game.images.fromCache('player/$character/${state}_16px.png'),
      SpriteAnimationData.sequenced(
        amount: amount,
        amountPerRow: amountPerRow,
        stepTime: _animationSpeed,
        textureSize: Vector2.all(16),
      ),
    );
  }

  SpriteAnimation _specialSpriteAnimation(String state, int amount) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache('player/$character/${state}_32.png'),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: _animationSpeed,
        textureSize: Vector2.all(32),
        loop: false,
      ),
    );
  }
}