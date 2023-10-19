import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'package:flutter/material.dart';
import 'package:warlords/constants.dart';

enum WallType { top, right, bottom, left }

class Wall extends PositionComponent {
  Wall(WallType type) {
    switch (type) {
      case WallType.top:
        position = Vector2.zero();
        size = Vector2(worldSize.x, wallThickness);
        break;

      case WallType.right:
        position = Vector2(worldSize.x - wallThickness, wallThickness);
        size = Vector2(wallThickness, worldSize.y - (2 * wallThickness));
        break;

      case WallType.bottom:
        position = Vector2(0, worldSize.y - wallThickness);
        size = Vector2(worldSize.x, wallThickness);
        break;

      case WallType.left:
        position = Vector2(0, wallThickness);
        size = Vector2(wallThickness, worldSize.y - (2 * wallThickness));
        break;
    }
    add(
      RectangleHitbox(
        position: Vector2.zero(),
        size: size,
      )
        ..renderShape = true
        ..setColor(Colors.white),
    );
  }
}
