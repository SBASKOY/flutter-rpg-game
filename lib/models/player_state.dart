import 'package:battle_royale/constant/contstant.dart';
import 'package:battle_royale/models/maps_state.dart';
import 'package:rxdart/rxdart.dart';

class PlayerState {
  static PlayerState? _instance;
  static PlayerState get instance {
    _instance ??= PlayerState._init();
    return _instance!;
  }

  PlayerState._init();

  final _health = new BehaviorSubject<int>.seeded(100);
  final _bulletsCount = new BehaviorSubject<int>.seeded(10);
  final speed = 100.0;
  bool isLastShow = false;
  int get health => _health.value;
  Stream<int> get healthStream => _health.stream;

  int get bulletsCount => _bulletsCount.value;
  Stream<int> get bulletsCountStream => _bulletsCount.stream;

  Function(int) get setHealth {
    this.isLastShow = false;
    return _health.sink.add;
  }

  Function(int) get setBulletsCount => _bulletsCount.sink.add;

  bool isShowTextDialog() => Constants.mapText[MapsState.instance.currentMap]!.keys.contains(this.health) && !this.isLastShow;
}
