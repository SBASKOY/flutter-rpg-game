import 'package:battle_royale/game/battle_royale_game.dart';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';

class HitBoxTile extends SpriteComponent with HasGameRef<BattleRoyaleGame>, HasHitboxes, Collidable {
  String src;
  Vector2 pos;

  HitBoxTile(this.src, this.pos) : super(size: Vector2.all(64));
  @override
  Future<void>? onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite(src);
    //Sprite(gameRef.images.fromCache(src));
    position = pos;
    var shape = HitboxRectangle();
    addHitbox(shape);
  }
}
