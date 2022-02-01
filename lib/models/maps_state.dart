import 'package:battle_royale/models/map_model.dart';
import 'package:rxdart/rxdart.dart';

class MapsState {
  static MapsState? _instance;
  static MapsState get instance {
    _instance ??= MapsState._init();
    return _instance!;
  }

  final mapSelectModel = new BehaviorSubject<MapSelectModel>();
  MapsState._init() {
    MapSelectModel.loadMaps().then((value) => {mapSelectModel.sink.add(value)});
  }
  String get currentMap => mapSelectModel.value.currentMap;
  void refresh() {
    var model = mapSelectModel.value;
     mapSelectModel.sink.add(model);
  }

  void selectMap(index) {
    var model = mapSelectModel.value;
    for (var element in model.maps) {
      element.isSelected = false;
    }
    model.maps[index].isSelected = true;
    model.selectMap(index);
    mapSelectModel.sink.add(model);
    model.saveMaps();
  }

  void nextMaps() {
    var model = mapSelectModel.value;
    var newMap = model.selectedID + 1;
    if (newMap < model.maps.length) {
      for (var element in model.maps) {
        element.isSelected = false;
      }
      model.maps[newMap].isSelected = true;
      model.maps[newMap].isLocked = false;
      model.selectMap(newMap);
      mapSelectModel.sink.add(model);
      model.saveMaps();
    }
  }
}
