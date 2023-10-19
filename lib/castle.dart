import 'dart:math';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:warlords/constants.dart';

enum BrickRunDirection { vertical, horizontal }

class Castle extends PositionComponent {
  final Color color;

  Castle({
    required this.color,
    required super.anchor,
    required super.angle,
    required super.position,
    required super.size,
  });

  @override
  Future<void> onLoad() async {
    for (var lidx = 0; lidx < numberOfLayers; lidx++) {
      await add(
        CastleLayer(
          layerLevel: lidx,
          color: color,
          bricksPerRun: layerConfig[lidx]!,
          position: Vector2(0, lidx * brickThickness),
          size: Vector2(
            size.x - lidx * brickThickness,
            size.y - lidx * brickThickness,
          ),
        ),
      );
    }

    return Future.value();
  }
}

class CastleLayer extends PositionComponent {
  final int layerLevel;
  final int bricksPerRun;
  final Color color;

  CastleLayer({
    required this.layerLevel,
    required this.color,
    required this.bricksPerRun,
    required super.position,
    required super.size,
  });

  @override
  Future<void> onLoad() async {
    await add(
      BrickRun(
        direction: BrickRunDirection.horizontal,
        brickCount: bricksPerRun,
        color: color,
        position: Vector2(0, 0),
        size: Vector2(
          size.x,
          brickThickness,
        ),
      ),
    );

    await add(
      BrickRun(
        direction: BrickRunDirection.vertical,
        brickCount: bricksPerRun,
        color: Colors.red,
        position: Vector2(size.x - brickThickness, brickThickness),
        size: Vector2(
          brickThickness,
          size.y - brickThickness,
        ),
      ),
    );

    return Future.value();
  }
}

class BrickRun extends PositionComponent {
  final BrickRunDirection direction;
  final int brickCount;
  final Color color;

  BrickRun({
    required this.direction,
    required this.brickCount,
    required this.color,
    required super.size,
    required super.position,
  });

  @override
  Future<void> onLoad() async {
    final brickLength = max(size.x, size.y) / brickCount;

    for (var bidx = 0; bidx < brickCount; bidx++) {
      await add(
        Brick(
          color: color,
          position: brickPosition(direction, brickLength, bidx),
          size: brickSize(direction, brickLength, bidx),
        ),
      );
    }

    return Future.value();
  }

  Vector2 brickPosition(
    BrickRunDirection direction,
    double brickLength,
    int bidx,
  ) =>
      direction == BrickRunDirection.horizontal
          ? Vector2(
              brickLength * bidx,
              0,
            )
          : Vector2(
              0,
              brickLength * bidx,
            );

  Vector2 brickSize(
    BrickRunDirection direction,
    double brickLength,
    int bidx,
  ) =>
      direction == BrickRunDirection.horizontal
          ? Vector2(
              brickLength,
              brickThickness,
            )
          : Vector2(
              brickThickness,
              brickLength,
            );
}

class Brick extends RectangleComponent {
  bool intact = true;

  Brick({
    required Color color,
    required super.size,
    required super.position,
  }) {
    paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;
  }
}
