import 'package:battle_royale/constant/contstant.dart';
import 'package:battle_royale/models/maps_state.dart';
import 'package:battle_royale/models/player_state.dart';
import 'package:rxdart/rxdart.dart';

class AppState {
  static AppState? _instance;
  static AppState get instance {
    _instance ??= AppState._init();
    return _instance!;
  }

  AppState._init();
  final _isFinishOnLoading = new BehaviorSubject<bool>.seeded(false);

  Function(bool) get setIsFinishLoading => _isFinishOnLoading.sink.add;

  bool get isFinishLoading => _isFinishOnLoading.value;
  Stream<bool> get isFinishLoadingStream => _isFinishOnLoading.stream;

  Map<String,String> get selectedText=> Constants.mapText[MapsState.instance.currentMap]![PlayerState.instance.health]!;
  

  final _loadingText = new BehaviorSubject<String>.seeded("Resimler alınıyor..");
  String get loadingText => _loadingText.value;
  Stream<String> get loadingTextStream => _loadingText.stream;
  Function(String) get setLoadingText => _loadingText.sink.add;
}
