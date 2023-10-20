import 'package:flame/components.dart';
import 'package:warlords/constants.dart';
import 'package:warlords/warlords_game.dart';

class Lord extends SpriteComponent with HasGameReference<WarlordsGame> {
  @override
  bool get debugMode => false;

  Lord({
    required super.sprite,
    required super.position,
  }) : super(size: lordSize, anchor: Anchor.center);

  @override
  Future<void> onLoad() async {}
}
