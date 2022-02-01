class EnemyState {
  static EnemyState? _instance;
  static EnemyState get instance {
    _instance ??= EnemyState._init();
    return _instance!;
  }

  EnemyState._init();
  final speed = 50.0;
  int health = 5;
  final playerMoveDistance = 300;
}
