import 'package:battle_royale/constant/contstant.dart';
import 'package:battle_royale/game/battle_royale_game.dart';
import 'package:battle_royale/game/components/bullet.dart';
import 'package:battle_royale/game/components/player.dart';
import 'package:battle_royale/game/components/plus.dart';
import 'package:battle_royale/models/app_state.dart';
import 'package:battle_royale/models/enemy_state.dart';
import 'package:battle_royale/models/player_state.dart';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';

class Enemy extends SpriteAnimationComponent with HasHitboxes, Collidable, HasGameRef<BattleRoyaleGame> {
  final double posX;
  final double posY;
  final String type;
  Enemy(this.posX, this.posY, this.type) : super(size: Vector2.all(32));

  late Vector2 _startPosition;
  @override
  Future<void>? onLoad() async {
    super.onLoad();

    var enemyAnimation = SpriteAnimation.spriteList([
      await gameRef.loadSprite("enemys/$type/0.png"),
      await gameRef.loadSprite("enemys/$type/1.png"),
      await gameRef.loadSprite("enemys/$type/2.png"),
      await gameRef.loadSprite("enemys/$type/3.png"),
      await gameRef.loadSprite("enemys/$type/4.png"),
      await gameRef.loadSprite("enemys/$type/5.png"),
      await gameRef.loadSprite("enemys/$type/6.png"),
      await gameRef.loadSprite("enemys/$type/7.png"),
      await gameRef.loadSprite("enemys/$type/8.png"),
      await gameRef.loadSprite("enemys/$type/9.png"),
      await gameRef.loadSprite("enemys/$type/10.png"),
      await gameRef.loadSprite("enemys/$type/11.png"),
    ], stepTime: 0.1);
    this.animation = enemyAnimation;
    this.position = Vector2(posX, posY);
    this._startPosition = Vector2(posX, posY);
    var shape = HitboxRectangle();
    addHitbox(shape);
    AppState.instance.setIsFinishLoading(true);
  }

  Vector2 get getRandomVector => (Vector2.random() - Vector2.random()) * 750;
  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    if (other is Player) {
      if (!other.stopMoving) {
        PlayerState.instance.setHealth(PlayerState.instance.health - Constants.enemyDamage);
      }
      var particle = ParticleComponent(Particle.generate(
          count: 100,
          lifespan: 0.1,
          generator: (i) {
            return AcceleratedParticle(
                acceleration: getRandomVector,
                position: this.position,
                child: CircleParticle(
                  radius: 1,
                  paint: Paint()..color = Colors.red,
                ));
          }));
      gameRef.add(particle);
      this.removeFromParent();
    }
    if (other is Bullet) {
      EnemyState.instance.health-=Constants.playerBulletCount;
      other.removeFromParent();
      if (EnemyState.instance.health <= 0) {
        this.removeFromParent();
      }
    }
    if (other is Plus) {
      other.removeFromParent();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    var diff = this.gameRef.player?.position.distanceTo(this.position);
    if ((diff ?? 500) < EnemyState.instance.playerMoveDistance) {
      this.position += (this.gameRef.player!.position - this.position).normalized() * EnemyState.instance.speed * dt;
    } else {
      this.position += (this._startPosition - this.position).normalized() * EnemyState.instance.speed * dt;
    }
  }
}
