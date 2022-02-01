import 'package:battle_royale/game/battle_royale_game.dart';
import 'package:battle_royale/game/components/tile.dart';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';

class Bullet extends SpriteComponent with HasHitboxes, Collidable, HasGameRef<BattleRoyaleGame> {
  Vector2 pos;
  Bullet(this.pos) : super(size: Vector2.all(24), position: pos);
  Vector2 _moveDirection = Vector2.zero();
  final _speed = 100.0;
  @override
  Future<void>? onLoad()  {
    super.onLoad();
    sprite = //await gameRef.loadSprite("bullets/5.png");
    Sprite(gameRef.images.fromCache("bullets/5.png"));
    position = pos;
    var shape = HitboxCircle(normalizedRadius: 1);
    addHitbox(shape);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);

    if (other is HitBoxTile) {
      removeFromParent();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += _moveDirection.normalized() * _speed * dt;
  }

  void setMoveDirection(Vector2 direction) {
    _moveDirection = direction;
  }
}
