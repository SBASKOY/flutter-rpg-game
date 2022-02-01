// ignore_for_file: must_call_super

import 'package:battle_royale/constant/contstant.dart';
import 'package:battle_royale/game/battle_royale_game.dart';
import 'package:battle_royale/game/components/bullet.dart';
import 'package:battle_royale/game/components/plus.dart';
import 'package:battle_royale/game/components/tile.dart';
import 'package:battle_royale/models/player_state.dart';
import 'package:battle_royale/widgets/game_over.dart';
import 'package:battle_royale/widgets/next_level.dart';
import 'package:battle_royale/widgets/status_bar.dart';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';

class Player extends SpriteAnimationComponent with HasGameRef<BattleRoyaleGame>, HasHitboxes, Collidable {
  final double posX;
  final double posY;

  Player(this.posX, this.posY)
      : super(
          size: Vector2.all(32.0),
        );

  Vector2 _moveDirection = Vector2.zero();
  PlayerDirection _playerDirectionCollisionX = PlayerDirection.none;
  PlayerDirection _playerDirectionCollisionY = PlayerDirection.none;
  PlayerDirection _playerDirectionY = PlayerDirection.none;
  PlayerDirection _playerDirectionX = PlayerDirection.none;
  bool _hasCollided = false;
  late SpriteAnimation _deadAnim;
  bool isNextLevel = false;
  bool isGameOver = false;
  bool stopMoving = false;
  @override
  Future<void> onLoad() async {
    super.onLoad();
    var walkAnim = SpriteAnimation.spriteList([
      await gameRef.loadSprite("players/boy/0.png"),
      await gameRef.loadSprite("players/boy/1.png"),
      await gameRef.loadSprite("players/boy/3.png"),
      await gameRef.loadSprite("players/boy/4.png"),
      await gameRef.loadSprite("players/boy/5.png"),
      await gameRef.loadSprite("players/boy/6.png"),
      await gameRef.loadSprite("players/boy/7.png"),
      await gameRef.loadSprite("players/boy/8.png"),
      await gameRef.loadSprite("players/boy/9.png"),
      await gameRef.loadSprite("players/boy/10.png"),
      await gameRef.loadSprite("players/boy/11.png"),
      await gameRef.loadSprite("players/boy/13.png"),
      await gameRef.loadSprite("players/boy/14.png"),
    ], stepTime: 0.1);
    _deadAnim = SpriteAnimation.spriteList([
      await gameRef.loadSprite("players/boy/dead/0.png"),
      await gameRef.loadSprite("players/boy/dead/1.png"),
      await gameRef.loadSprite("players/boy/dead/3.png"),
      await gameRef.loadSprite("players/boy/dead/4.png"),
      await gameRef.loadSprite("players/boy/dead/5.png"),
      await gameRef.loadSprite("players/boy/dead/6.png"),
      await gameRef.loadSprite("players/boy/dead/7.png"),
      await gameRef.loadSprite("players/boy/dead/8.png"),
      await gameRef.loadSprite("players/boy/dead/9.png"),
      await gameRef.loadSprite("players/boy/dead/10.png"),
      await gameRef.loadSprite("players/boy/dead/11.png"),
      await gameRef.loadSprite("players/boy/dead/13.png"),
      await gameRef.loadSprite("players/boy/dead/14.png"),
    ], stepTime: 0.3);
    this.animation = walkAnim;
    position = Vector2(posX, posY);
    anchor = Anchor.center;
    var shape = HitboxCircle(normalizedRadius: 0.7);
    addHitbox(shape);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    if (other is HitBoxTile) {
      if (!this._hasCollided) {
        this._hasCollided = true;
        this._playerDirectionCollisionX = this._playerDirectionX;
        this._playerDirectionCollisionY = this._playerDirectionY;
      }
    }
    if (other is Plus) {
      PlayerState.instance.setHealth(PlayerState.instance.health + Constants.plusHealth);
      other.removeFromParent();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (PlayerState.instance.health <= 0) {
      isGameOver = true;
      PlayerState.instance.setHealth(1);
    }
    if (isGameOver) {
      this.animation = _deadAnim;
      gameRef.overlays.remove(StatusBar.id);
      isGameOver = false;
      stopMoving = true;
      Future.delayed(Duration(seconds: animation!.totalDuration().toInt())).then((val) {
        gameRef.pauseEngine();
        gameRef.overlays.add(GameOver.id);
      });
    }
    if (isNextLevel) {
      this.animation = _deadAnim;
      gameRef.overlays.remove(StatusBar.id);
      isNextLevel = false;
      stopMoving = true;
      Future.delayed(Duration(seconds: animation!.totalDuration().toInt())).then((val) {
        gameRef.pauseEngine();
        gameRef.overlays.add(NextLevel.id);
      });
    }
    if (!stopMoving) {
      if (_hasCollided) {
        if (!canGoY) {
          this._moveDirection.y = 0;
        }
        if (!canGoX) {
          this._moveDirection.x = 0;
        }
      }
      this.position += _moveDirection.normalized() * dt * PlayerState.instance.speed;

      this.gameRef.camera.followComponent(this);
      this._hasCollided = false;
    }
  }

  bool get canGoX => _playerDirectionX != _playerDirectionCollisionX;
  bool get canGoY => _playerDirectionY != _playerDirectionCollisionY;

  void setMoveDirection(double x, double y) {
    this._playerDirectionX = this.findDirectionX(x);
    this._playerDirectionY = this.findDirectionY(y);
    this._moveDirection = Vector2(x, y);
  }

  PlayerDirection findDirectionX(double x) {
    if (x < 0) {
      return PlayerDirection.left;
    }
    if (x > 0) {
      return PlayerDirection.right;
    }
    return PlayerDirection.none;
  }

  PlayerDirection findDirectionY(double y) {
    if (y < 0) {
      return PlayerDirection.up;
    }
    if (y > 0) {
      return PlayerDirection.down;
    }
    return PlayerDirection.none;
  }

  void addBullet(Vector2 moveDirection) {
    if (PlayerState.instance.bulletsCount > 0) {
      var bullet = new Bullet(position.clone());
      bullet.setMoveDirection(moveDirection - position);
      gameRef.add(bullet);
      PlayerState.instance.setBulletsCount(PlayerState.instance.bulletsCount - 1);
      if (PlayerState.instance.bulletsCount <= 0) {
        PlayerState.instance.setBulletsCount(0);
      }
    }
  }
}

enum PlayerDirection { up, down, left, right, none }
