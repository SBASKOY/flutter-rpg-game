import 'package:flame/components.dart';
import 'package:flame/geometry.dart';

import '../battle_royale_game.dart';

class Plus extends SpriteComponent with HasGameRef<BattleRoyaleGame>, HasHitboxes, Collidable {
  String src;
  Vector2 pos;

  Plus(this.src, this.pos) : super(size: Vector2.all(16));
  @override
  Future<void>? onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite(src);
    //Sprite(gameRef.images.fromCache(src));
    position = pos;
    var shape = HitboxCircle(normalizedRadius: 1.5);
    addHitbox(shape);
  }
}
