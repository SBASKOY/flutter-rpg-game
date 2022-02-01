import 'package:battle_royale/game/battle_royale_game.dart';
import 'package:battle_royale/game/components/enemy.dart';
import 'package:battle_royale/game/components/girl.dart';
import 'package:battle_royale/game/components/player.dart';
import 'package:battle_royale/game/components/plus.dart';
import 'package:battle_royale/game/components/tile.dart';
import 'package:battle_royale/models/app_state.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

class BattleRoyaleMap extends Component with HasGameRef<BattleRoyaleGame> {
  BattleRoyaleMap();

  @override
  Future<void>? onLoad() async {
    super.onLoad();
    AppState.instance.setLoadingText("Harita yükleniyor...");
    final map = await TiledComponent.load(gameRef.mapName, Vector2.all(64));
    add(map);
    AppState.instance.setLoadingText("Componentler yükleniyor...");
    var forest = map.tileMap.getObjectGroupFromLayer("collision");
    for (var point in forest.objects) {
      if (point.name == "player") {
        if (point.type == "boy") {
          gameRef.player = new Player(point.x, point.y);
          add(gameRef.player!);
        } else {
          var girl = new Girl(point.x, point.y);
          add(girl);
        }
      } else if (point.name == "enemy") {
        var enemy = new Enemy(point.x, point.y, point.type);
        add(enemy);
      } else if (point.name == "utils") {
        if (point.type == "plus") {
          var plus = Plus("utils/${point.type}.png", Vector2(point.x, point.y));
          add(plus);
        }
      } else {
        var hitboxTile = HitBoxTile(
          "layers/${point.name}.png",
          Vector2(point.x, point.y),
        );
        add(hitboxTile);
      }
    }
    AppState.instance.setIsFinishLoading(true);
  }
}
