import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:warlords/constants.dart';
import 'package:warlords/continent.dart';

class WarlordsGame extends FlameGame {
  @override
  bool get debugMode => false;

  @override
  Future<void> onLoad() async {
    final world = World()
      ..add(Continent(
        position: Vector2.zero(),
        size: worldSize,
      ));

    add(world);

    final viewport = FixedAspectRatioViewport(aspectRatio: 1);
    final camera = CameraComponent(world: world, viewport: viewport);

    camera.viewport.size = worldSize;
    camera.viewfinder.zoom = 1.0;
    camera.viewfinder.visibleGameSize = worldSize;
    camera.viewfinder.position = worldSize / 2;
    camera.viewfinder.anchor = Anchor.center;

    add(camera);
  }
}
