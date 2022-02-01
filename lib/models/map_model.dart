import 'dart:convert';

import 'package:battle_royale/constant/contstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapModel {
  String name;
  String assetImage;
  String altText;
  bool isLocked;
  bool isSelected;
  MapModel(this.name, this.assetImage, this.altText, this.isLocked, {this.isSelected = false});
  factory MapModel.fromJson(json) {
    var name = json["name"];
    var assetImage = json["assetImage"];
    var altText = json["altText"];
    var isLocked = json["isLocked"];
    var isSelected = json["isSelected"];
    return MapModel(name, assetImage, altText, isLocked, isSelected: isSelected);
  }
  Map<String, dynamic> toJson() => {
        "name": name,
        "assetImage": assetImage,
        "altText": altText,
        "isLocked": isLocked,
        "isSelected": isSelected,
      };
}

extension MapModelExtension on MapModel {
  String get getMapName => "${this.name}.tmx";
  String get assetName => "assets/images/layers/${this.assetImage}.png";
  AssetImage get image => AssetImage(this.assetName);
}

class MapSelectModel {
  int selectedID;
  List<MapModel> maps;
  MapSelectModel(this.selectedID, this.maps);

  factory MapSelectModel.fromJson(json) {
    var selectedID = json["selectedID"];
    List<MapModel> maps = [];
    for (var item in json["maps"]) {
      maps.add(MapModel.fromJson(item));
    }
    return new MapSelectModel(selectedID, maps);
  }
  static Future<MapSelectModel> loadMaps() async {
    var prefences = await SharedPreferences.getInstance();
    var mapSelectedModel = prefences.getString("maps");
    if (mapSelectedModel?.isEmpty ?? true) {
      return new MapSelectModel(0, Constants.getMaps);
    }
    //return new MapSelectModel(0, Constants.getMaps);
    return MapSelectModel.fromJson(jsonDecode(mapSelectedModel!));
  }

  String get currentMap => maps[selectedID].getMapName;
  void selectMap(index) {
    if (index < maps.length) {
      selectedID = index;
    }
  }

  void saveMaps() async {
    var json = this.toJson();
    var mapsText = jsonEncode(json);
    var prefences = await SharedPreferences.getInstance();
    prefences.setString("maps", mapsText);
  }

  Map<String, dynamic> toJson() => {"selectedID": selectedID, "maps": maps.map((e) => e.toJson()).toList()};
}
