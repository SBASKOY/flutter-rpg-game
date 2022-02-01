import 'package:battle_royale/game/battle_royale_game.dart';
import 'package:battle_royale/models/app_state.dart';
import 'package:battle_royale/models/player_state.dart';
import 'package:battle_royale/widgets/custom_button.dart';
import 'package:battle_royale/widgets/status_bar.dart';
import 'package:battle_royale/widgets/title_text.dart';
import 'package:flutter/material.dart';

class TextDialogs extends StatelessWidget {
  final BattleRoyaleGame gameRef;
  const TextDialogs({Key? key, required this.gameRef}) : super(key: key);
  static const String id = "TextDialog";
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 200,
        width: double.infinity,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          color: Colors.black.withOpacity(0.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTitleText(text: AppState.instance.selectedText["title"] ?? "Hey Beni Dinle !!"),
              ),
              Text(AppState.instance.selectedText["text"] ?? "Zaman Akıp gidiyor.."),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0, right: 16),
                child: CustomButton(
                  onPressed: () {
                    gameRef.overlays.remove(TextDialogs.id);
                    gameRef.overlays.add(StatusBar.id);
                    PlayerState.instance.isLastShow = true;
                    gameRef.resumeEngine();
                  },
                  text: "Kapat",
                  width: 75,
                  height: 25,
                  fontSize: 15,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
