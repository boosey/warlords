import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:warlords/castle.dart';
import 'package:warlords/constants.dart';
import 'package:warlords/lord.dart';
import 'package:warlords/wall.dart';

class WarlordsGame extends FlameGame {
  WarlordsGame();

  @override
  bool get debugMode => false;

  @override
  Future<void> onLoad() async {
    // await Flame.images.load('klondike-sprites.png');
    await Flame.images.loadAll([
      'star.png',
    ]);

    final tlLord = Lord(position: lordPositionOffset);

    final brLord = Lord(position: worldSize - lordPositionOffset);

    final trLord = Lord(
      position:
          Vector2(worldSize.x - lordPositionOffset.x, lordPositionOffset.y),
    );

    final blLord = Lord(
      position:
          Vector2(lordPositionOffset.x, worldSize.y - lordPositionOffset.y),
    );

    final world = World()
      ..add(tlLord)
      ..add(brLord)
      ..add(trLord)
      ..add(blLord)
      ..add(
        Castle(
          color: Colors.blue,
          anchor: Anchor.topLeft,
          angle: 0,
          position: Vector2(wallThickness,
              worldSize.y - (worldSize.y / worldDivider) - wallThickness),
          size: Vector2(worldSize.x / worldDivider, worldSize.y / worldDivider),
        ),
      )
      ..add(
        Castle(
          color: Colors.red,
          anchor: Anchor.topLeft,
          angle: 0,
          position: Vector2(wallThickness, wallThickness),
          size: Vector2(worldSize.x / worldDivider, worldSize.y / worldDivider),
        )..flipVerticallyAroundCenter(),
      )
      ..add(
        Castle(
          color: Colors.green,
          anchor: Anchor.topLeft,
          angle: 0,
          position: Vector2(
            worldSize.x - (worldSize.y / worldDivider) - wallThickness,
            worldSize.y - (worldSize.y / worldDivider) - wallThickness,
          ),
          size: Vector2(worldSize.x / worldDivider, worldSize.y / worldDivider),
        )..flipHorizontallyAroundCenter(),
      )
      ..add(
        Castle(
          color: Colors.purple,
          anchor: Anchor.topLeft,
          angle: 0,
          position: Vector2(
            worldSize.x - (worldSize.y / worldDivider) - wallThickness,
            wallThickness,
          ),
          size: Vector2(worldSize.x / worldDivider, worldSize.y / worldDivider),
        )
          ..flipHorizontallyAroundCenter()
          ..flipVerticallyAroundCenter(),
      )
      ..add(Wall(WallType.top))
      ..add(Wall(WallType.left))
      ..add(Wall(WallType.right))
      ..add(Wall(WallType.bottom));
    add(world);

    final viewport = FixedAspectRatioViewport(aspectRatio: 1);
    final camera = CameraComponent(world: world, viewport: viewport);

    // final camera = CameraComponent(world: world);
    camera.viewport.size = worldSize;
    camera.viewfinder.zoom = 1.0;
    camera.viewfinder.visibleGameSize = worldSize;
    camera.viewfinder.position = worldSize / 2;
    camera.viewfinder.anchor = Anchor.center;

    add(camera);
  }
}
