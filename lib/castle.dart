import 'dart:math';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

import 'package:warlords/constants.dart';

enum BrickRunDirection { vertical, horizontal, corner }

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
      simpleRun(
        direction: BrickRunDirection.horizontal,
        runLength: straightRunLength(),
        thickness: brickThickness,
        color: color,
        count: bricksPerRun,
      ),
    );

    await add(
      simpleRun(
        direction: BrickRunDirection.vertical,
        runLength: straightRunLength(),
        thickness: brickThickness,
        color: color,
        count: bricksPerRun,
      ),
    );

    final cornerLength = Vector2(straightRunLength(), 0).distanceTo(
      Vector2(size.x, size.y - straightRunLength()),
    );

    await add(simpleRun(
      direction: BrickRunDirection.corner,
      count: 1,
      color: color,
      runLength: cornerLength,
      thickness:
          brickThickness + 19, // Complete hack Found through trial and error
    ));

    return Future.value();
  }

  double straightRunLength() => size.x * straightRunLengthPercentage;

  BrickRun simpleRun({
    required BrickRunDirection direction,
    required double runLength,
    required double thickness,
    required Color color,
    required int count,
  }) {
    return BrickRun(
      direction: direction,
      brickCount: count,
      thickness: thickness,
      color: color,
      size: Vector2(runLength, thickness),
      position: calculatePosition(direction, runLength),
    );
  }

  Vector2 calculatePosition(BrickRunDirection direction, double length) =>
      switch (direction) {
        BrickRunDirection.horizontal => Vector2.zero(),
        BrickRunDirection.vertical => Vector2(size.x, size.y - length),
        BrickRunDirection.corner => Vector2(straightRunLength(), 0),
      };
}

class BrickRun extends PositionComponent {
  final BrickRunDirection direction;
  final int brickCount;
  final Color color;
  final double thickness;

  BrickRun({
    required this.direction,
    required this.brickCount,
    required this.color,
    required super.size,
    required super.position,
    required this.thickness,
  });

  @override
  bool get debugMode => false;

  @override
  Future<void> onLoad() async {
    final brickLength = max(size.x, size.y) / brickCount;

    for (var bidx = 0; bidx < brickCount; bidx++) {
      await add(
        Brick(
          color: color,
          position: brickPosition(brickLength, bidx),
          size: Vector2(brickLength, thickness),
        ),
      );

      angle = runAngle();
    }

    return Future.value();
  }

  double runAngle() => switch (direction) {
        BrickRunDirection.horizontal => 0,
        BrickRunDirection.vertical => pi / 2,
        BrickRunDirection.corner => pi / 4,
      };

  Vector2 brickPosition(double brickLength, int bidx) =>
      Vector2(brickLength * bidx, 0);

  double runLength() => size.x * straightRunLengthPercentage;

  // Vector2 brickSize(double brickLength) => Vector2(brickLength, brickThickness);
  // Vector2 cornerBrickSize(double brickLength) =>
  //     Vector2(brickLength, brickThickness + 1);
}

class Brick extends RectangleComponent {
  bool intact = true;

  Brick({
    required Color color,
    required super.size,
    required super.position,
  }) {
    paint = Paint()
      ..shader = Gradient.linear(
        const Offset(0, 0),
        Offset(size.x, size.y),
        [color, color.brighten(0.5)],
      )
      // ..style = PaintingStyle.fill
      ..color = color;
  }
}
