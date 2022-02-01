import 'package:battle_royale/game/battle_royale_game.dart';
import 'package:battle_royale/pages/start_page.dart';
import 'package:battle_royale/widgets/status_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'custom_button.dart';

class PauseMenu extends StatelessWidget {
  final BattleRoyaleGame gameRef;
  const PauseMenu({Key? key, required this.gameRef}) : super(key: key);
  static String id = "PauseMenu";
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.black.withOpacity(0.7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  "Game Paused",
                  // specialElite
                  style: GoogleFonts.specialElite(fontSize: 30, color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: CustomButton(
                  onPressed: () {
                    gameRef.overlays.remove(PauseMenu.id);
                    gameRef.overlays.add(StatusBar.id);
                    gameRef.resumeEngine();
                  },
                  text: "Resume",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: CustomButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c) {
                      return const StartPage();
                    }));
                  },
                  text: "Go Home",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
