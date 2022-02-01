import 'package:battle_royale/pages/start_page.dart';

import 'package:flame/flame.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();

  runApp(MaterialApp(
    title: "Battle-Royale 2D",
    debugShowCheckedModeBanner: false,
    home: const StartPage(),
    theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black.withOpacity(0.5)),
  ));
}
