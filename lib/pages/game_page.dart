import 'package:battle_royale/game/battle_royale_game.dart';
import 'package:battle_royale/models/map_model.dart';
import 'package:battle_royale/models/maps_state.dart';
import 'package:battle_royale/pages/loading_page.dart';
import 'package:battle_royale/widgets/game_over.dart';
import 'package:battle_royale/widgets/next_level.dart';
import 'package:battle_royale/widgets/status_bar.dart';
import 'package:battle_royale/widgets/pause_menu.dart';
import 'package:battle_royale/widgets/text_dialogs.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          children: [
            Center(
              child: SizedBox(
                child: StreamBuilder<MapSelectModel>(
                    stream: MapsState.instance.mapSelectModel,
                    builder: (context, snapshot) {
                      return GameWidget(
                        //loadingBuilder: (context) => const LoadingPage(),
                        initialActiveOverlays: const [LoadingPage.id, StatusBar.id],
                        overlayBuilderMap: {
                          PauseMenu.id: (context, BattleRoyaleGame gameRef) {
                            return PauseMenu(
                              gameRef: gameRef,
                            );
                          },
                          LoadingPage.id: (context, BattleRoyaleGame gameRef) {
                            return LoadingPage(
                              gameRef: gameRef,
                            );
                          },
                          StatusBar.id: (context, BattleRoyaleGame gameRef) {
                            return StatusBar(
                              gameRef: gameRef,
                            );
                          },
                          TextDialogs.id: (context, BattleRoyaleGame gameRef) {
                            return TextDialogs(
                              gameRef: gameRef,
                            );
                          },
                          NextLevel.id: (context, BattleRoyaleGame gameRef) {
                            return NextLevel(
                              gameRef: gameRef,
                            );
                          },
                          GameOver.id: (context, BattleRoyaleGame gameRef) {
                            return GameOver(
                              gameRef: gameRef,
                            );
                          },
                        },
                        game: new BattleRoyaleGame(
                          snapshot.data?.currentMap ?? "map.tmx",
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
