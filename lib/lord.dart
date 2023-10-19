import 'package:flame/components.dart';
import 'package:warlords/constants.dart';
import 'package:warlords/warlords_game.dart';

// class Lord extends PositionComponent {
//   @override
//   bool get debugMode => true;
// }

class Lord extends SpriteComponent with HasGameReference<WarlordsGame> {
  @override
  bool get debugMode => true;

  Lord({
    required super.position,
  }) : super(size: lordSize, anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    final lordImage = game.images.fromCache('star.png');
    sprite = Sprite(lordImage);
  }
}
