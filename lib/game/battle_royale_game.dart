import 'package:battle_royale/constant/contstant.dart';
import 'package:battle_royale/game/components/player.dart';
import 'package:battle_royale/game/layer/map.dart';
import 'package:battle_royale/models/app_state.dart';
import 'package:battle_royale/models/maps_state.dart';
import 'package:battle_royale/models/player_state.dart';
import 'package:battle_royale/widgets/status_bar.dart';
import 'package:battle_royale/widgets/text_dialogs.dart';

import 'package:flame/game.dart';
import 'package:flame/input.dart';

import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';

class BattleRoyaleGame extends FlameGame with TapDetector, HasCollidables {
  final String mapName;
  BattleRoyaleGame(this.mapName);
  Player? player;
  Vector2? _pointerStartPosition;
  Vector2? _pointerCurrentPosition;

  BattleRoyaleMap? _map;
  String selectedMap = "map.tmx";
  @override
  Future<void>? onLoad() async {
    super.onLoad();

    await images.loadAll(Constants.getImageList);
    selectedMap = MapsState.instance.currentMap;
    print("on attach");
    loadMap();
  }

  void loadMap() {
    _map?.removeFromParent();
    _map = BattleRoyaleMap();
    add(_map!);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    var paint = new Paint()..color = Colors.grey.withAlpha(100);

    if (_pointerStartPosition != null) {
      canvas.drawCircle(
        _pointerStartPosition!.toOffset(),
        60,
        paint,
      );

      Offset delta;
      var diff = _pointerCurrentPosition!.distanceTo(_pointerStartPosition!);
      if (diff > 60) {
        delta = _pointerStartPosition!.toOffset() +
            ((_pointerCurrentPosition! - _pointerStartPosition!).normalized() * 60).toOffset();
      } else {
        delta = _pointerCurrentPosition!.toOffset();
      }
      canvas.drawCircle(
        delta,
        20,
        paint,
      );
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (PlayerState.instance.isShowTextDialog() && AppState.instance.isFinishLoading) {
      player?.setMoveDirection(0, 0);
      this.pauseEngine();
      this.overlays.remove(StatusBar.id);
      this.overlays.add(TextDialogs.id);
    }
  }

  reset() {
    this.removeAll(this.children);

    selectedMap = MapsState.instance.currentMap;
  }

  @override
  void onTapDown(TapDownInfo info) {
    player!.addBullet(info.eventPosition.game);
    super.onTapDown(info);
  }

  void onPanUpdate(StickDragDetails info) {
    player?.setMoveDirection(info.x, info.y);
    // _pointerCurrentPosition = info.eventPosition.viewport;
    // var delta = _pointerCurrentPosition! - _pointerStartPosition!;
    // player!.setMoveDirection(delta);
  }
  // void onPanStart(DragStartDetails info) {
  //   print(info.globalPosition.direction);
  // _pointerStartPosition = info.eventPosition.viewport;
  // _pointerCurrentPosition = info.eventPosition.viewport;
  // }

  void onPanEnd() {
    player?.setMoveDirection(0, 0);
  }

  // void onPanCancel() {
  //   _pointerStartPosition = null;
  //   _pointerCurrentPosition = null;
  //   player!.setMoveDirection(Vector2.zero());
  // }
}
