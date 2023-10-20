import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:warlords/castle.dart';
import 'package:warlords/lord.dart';

class Realm extends PositionComponent {
  final Color color;
  final bool hFlip;
  final bool vFlip;
  final Image lordSpriteImg;

  Realm({
    required this.color,
    required super.position,
    required super.size,
    required this.lordSpriteImg,
    this.hFlip = false,
    this.vFlip = false,
  });

  @override
  Future<void> onLoad() async {
    final c = Castle(
      color: color,
      anchor: Anchor.topLeft,
      position: Vector2.zero(),
      size: size,
    );

    final l = Lord(
      position: Vector2(size.x / 3, size.y / 3 * 2),
      sprite: Sprite(
        lordSpriteImg,
      ),
    )..scale = Vector2.all(2);

    add(c);
    add(l);

    if (hFlip) {
      flipHorizontallyAroundCenter();
      l.flipHorizontallyAroundCenter();
    }
    if (vFlip) {
      flipVerticallyAroundCenter();
      l.flipVerticallyAroundCenter();
    }
  }
}
