import 'package:battle_royale/game/battle_royale_game.dart';
import 'package:battle_royale/models/player_state.dart';
import 'package:battle_royale/widgets/pause_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';

class StatusBar extends StatelessWidget {
  final BattleRoyaleGame gameRef;
  const StatusBar({Key? key, required this.gameRef}) : super(key: key);
  static const String id = "PauseButton";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            // alignment: Alignment.topCenter,
            children: [
              StreamBuilder<int>(
                  stream: PlayerState.instance.healthStream,
                  initialData: 100,
                  builder: (c, snap) {
                    return Text("Kalan Can ${snap.data}");
                  }),
              const Spacer(),
              TextButton(
                child: const Icon(
                  Icons.pause,
                  color: Colors.white,
                ),
                onPressed: () {
                  gameRef.overlays.add(PauseMenu.id);
                  gameRef.overlays.remove(StatusBar.id);
                  gameRef.pauseEngine();
                },
              ),
              const Spacer(),
              StreamBuilder<int>(
                  stream: PlayerState.instance.bulletsCountStream,
                  initialData: 10,
                  builder: (c, snap) {
                    return Text("Kalan Mermi ${snap.data}");
                  }),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left:16.0,bottom: 16),
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Joystick(
                    listener: gameRef.onPanUpdate,
                    onStickDragEnd: gameRef.onPanEnd,
                  ),
                ),
              ),
              
            ],
          )
        ],
      ),
    );
  }
}
