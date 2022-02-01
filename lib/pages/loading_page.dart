import 'package:battle_royale/game/battle_royale_game.dart';
import 'package:battle_royale/models/app_state.dart';
import 'package:battle_royale/widgets/title_text.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  final BattleRoyaleGame gameRef;
  const LoadingPage({Key? key, required this.gameRef}) : super(key: key);
  static const String id = "Loading";
  @override
  Widget build(BuildContext context) {
    AppState.instance.isFinishLoadingStream.listen((value) {
      if (value) {
        gameRef.overlays.remove(LoadingPage.id);
        //gameRef.resumeEngine();
      }
    });
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder<String>(
                stream: AppState.instance.loadingTextStream,
                initialData: "Oyun yükleniyor..",
                builder: (c, snap) {
                  return CustomTitleText(text: snap.data.toString());
                },
              ),
              const CircularProgressIndicator.adaptive()
            ],
          ),
        ),
      ),
    );
  }
}
