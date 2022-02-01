// ignore_for_file: must_call_super

import 'package:battle_royale/game/battle_royale_game.dart';

import 'package:flame/components.dart';
import 'package:flame/geometry.dart';

class Girl extends SpriteAnimationComponent with HasGameRef<BattleRoyaleGame>, HasHitboxes, Collidable {
  final double posX;
  final double posY;

  Girl(this.posX, this.posY)
      : super(
          size: Vector2.all(32.0),
        );
  bool isRun = false;
  @override
  Future<void> onLoad() async {
    super.onLoad();
    var walkAnim = SpriteAnimation.spriteList([
      await gameRef.loadSprite("players/girl/0.png"),
      await gameRef.loadSprite("players/girl/1.png"),
      await gameRef.loadSprite("players/girl/2.png"),
      await gameRef.loadSprite("players/girl/3.png"),
      await gameRef.loadSprite("players/girl/4.png"),
      await gameRef.loadSprite("players/girl/5.png"),
      await gameRef.loadSprite("players/girl/6.png"),
      await gameRef.loadSprite("players/girl/7.png"),
      await gameRef.loadSprite("players/girl/8.png"),
      await gameRef.loadSprite("players/girl/9.png"),
      await gameRef.loadSprite("players/girl/10.png"),
      await gameRef.loadSprite("players/girl/11.png"),
      await gameRef.loadSprite("players/girl/13.png"),
      await gameRef.loadSprite("players/girl/14.png"),
      await gameRef.loadSprite("players/girl/15.png"),
    ], stepTime: 0.1);
    this.animation = walkAnim;
    position = Vector2(posX, posY);
    anchor = Anchor.center;
    var shape = HitboxCircle(normalizedRadius: 0.7);
    addHitbox(shape);
  }

  @override
  void update(double dt) {
    super.update(dt);
    var diff = this.gameRef.player?.position.distanceTo(this.position);
    if ((diff ?? 100) < 30) {
      gameRef.player?.isNextLevel = true;
      isRun = true;
    }
    if (isRun) {
      this.position += (Vector2.random() * 500).normalized() * dt * 100;
    }
  }
}
