import 'package:battle_royale/constant/contstant.dart';
import 'package:battle_royale/game/battle_royale_game.dart';
import 'package:battle_royale/models/maps_state.dart';
import 'package:battle_royale/models/player_state.dart';
import 'package:battle_royale/pages/start_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'custom_button.dart';

class GameOver extends StatelessWidget {
  final BattleRoyaleGame gameRef;
  const GameOver({Key? key, required this.gameRef}) : super(key: key);
  static String id = "GameOver";
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
                  "YİNE BAŞARAMADIK BE",
                  // specialElite
                  style: GoogleFonts.specialElite(fontSize: 30, color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: CustomButton(
                  onPressed: () {
                    PlayerState.instance.setHealth(Constants.playerHealth);
                    PlayerState.instance.setBulletsCount(Constants.playerBulletCount);
                    MapsState.instance.refresh();
                  },
                  text: "Pes Etme",
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
