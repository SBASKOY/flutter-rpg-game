import 'dart:io';
import 'package:battle_royale/models/map_model.dart';
import 'package:battle_royale/models/maps_state.dart';
import 'package:battle_royale/pages/game_page.dart';
import 'package:battle_royale/widgets/custom_button.dart';
import 'package:battle_royale/widgets/title_text.dart';
import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            Expanded(
              child: Card(
                color: Colors.grey.withOpacity(0.2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                margin: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: CustomTitleText(text: "Save My Love"),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: CustomTitleText(
                        text: "Geçti zaman,eridi sevdam",
                        fontSize: 15,
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: CustomButton(
                          text: "Start",
                          onPressed: () {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c) {
                              return const GamePage();
                            }));
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: CustomButton(
                          text: "Exit",
                          onPressed: () {
                            exit(0);
                          }),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            Expanded(
                child: Card(
              color: Colors.grey.withOpacity(0.2),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: CustomTitleText(text: "Select Map"),
                  ),
                  Expanded(
                    child: StreamBuilder<MapSelectModel>(
                        stream: MapsState.instance.mapSelectModel,
                        builder: (context, snap) {
                          if (snap.hasData) {
                            return PageView.builder(
                              controller: new PageController(initialPage: snap.data!.selectedID),
                              itemCount: snap.data?.maps.length ?? 0,
                              itemBuilder: (context, index) {
                                MapModel mapModel = snap.data!.maps[index];
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Stack(
                                      alignment: AlignmentDirectional.center,
                                      children: [
                                        SizedBox(
                                          width: 150,
                                          height: 150,
                                          child: Opacity(
                                            opacity: mapModel.isLocked ? 0.5 : 1,
                                            child: Image(
                                              image: mapModel.image,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        if (mapModel.isLocked)
                                          const Icon(
                                            Icons.lock,
                                            size: 32,
                                          )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 40.0),
                                      child: CustomTitleText(
                                        text: mapModel.altText,
                                        fontSize: 20,
                                      ),
                                    ),
                                    ElevatedButton(
                                        onPressed: mapModel.isSelected
                                            ? null
                                            : mapModel.isLocked
                                                ? null
                                                : () {
                                                    MapsState.instance.selectMap(index);
                                                  },
                                        child: Text(mapModel.isSelected ? "Selected" : "Select"))
                                  ],
                                );
                              },
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        }),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
