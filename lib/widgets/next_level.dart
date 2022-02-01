import 'package:battle_royale/constant/contstant.dart';
import 'package:battle_royale/game/battle_royale_game.dart';
import 'package:battle_royale/models/maps_state.dart';
import 'package:battle_royale/models/player_state.dart';
import 'package:battle_royale/pages/start_page.dart';
import 'package:battle_royale/widgets/status_bar.dart';
import 'package:battle_royale/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'custom_button.dart';

class NextLevel extends StatelessWidget {
  final BattleRoyaleGame gameRef;
  const NextLevel({Key? key, required this.gameRef}) : super(key: key);
  static String id = "NextLevel";
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
                  "Opss!! GİTMEEEE",
                  // specialElite
                  style: GoogleFonts.specialElite(fontSize: 30, color: Colors.white),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: CustomTitleText(
                  text: "Canımı hiç bi canavar senin kadar yakmamıştı :(",
                  fontSize: 16,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: CustomButton(
                  onPressed: () {
                   
                    gameRef.overlays.remove(NextLevel.id);
                    gameRef.overlays.add(StatusBar.id);
                    PlayerState.instance.setHealth(Constants.playerHealth);
                    PlayerState.instance.setBulletsCount(Constants.playerBulletCount);
                    MapsState.instance.nextMaps();
                    //  print("go back");
                    // gameRef.resumeEngine();
                    // gameRef.reset();
                  },
                  text: "Peşinden Git",
                  fontSize: 15,
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
