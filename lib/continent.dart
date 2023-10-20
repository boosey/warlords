import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:warlords/constants.dart';
import 'package:warlords/realm.dart';

class Continent extends PositionComponent {
  Continent({
    required super.position,
    required super.size,
  });

  @override
  bool get debugMode => false;

  @override
  Future<void> onLoad() async {
    await Flame.images.loadAll([
      'w1.png',
      'w2.png',
      'w3.png',
      'w4.png',
    ]);

    add(
      ContinentalBoundary(
        continentSize: size,
      ),
    );
    add(
      LandMass(
        position: Vector2.all(wallThickness),
        size: Vector2(
          size.x - (wallThickness * 2),
          size.y - (wallThickness * 2),
        ),
      ),
    );
  }
}

class LandMass extends PositionComponent {
  LandMass({
    required super.size,
    required super.position,
  });

  @override
  Future<void> onLoad() async {
    final realmSize =
        Vector2(size.x / continentDivider, size.y / continentDivider);

    add(
      Realm(
        color: Colors.blue,
        position: Vector2(0, size.y - realmSize.y),
        size: realmSize,
        lordSpriteImg: Flame.images.fromCache('w4.png'),
      ),
    );
    add(
      Realm(
        color: Colors.red,
        position: Vector2.zero(),
        size: realmSize,
        lordSpriteImg: Flame.images.fromCache('w1.png'),
        vFlip: true,
      ),
    );
    add(
      Realm(
        color: Colors.green,
        position: Vector2(
          size.x - realmSize.x,
          size.y - realmSize.y,
        ),
        size: realmSize,
        lordSpriteImg: Flame.images.fromCache('w2.png'),
        hFlip: true,
      ),
    );
    add(
      Realm(
        color: Colors.purple,
        position: Vector2(
          size.x - realmSize.x,
          0,
        ),
        size: realmSize,
        lordSpriteImg: Flame.images.fromCache('w3.png'),
        hFlip: true,
        vFlip: true,
      ),
    );
  }
}

class ContinentalBoundary extends PositionComponent {
  final Vector2 continentSize;

  ContinentalBoundary({
    required this.continentSize,
  });

  @override
  Future<void> onLoad() async {
    add(
      //Top
      RectangleHitbox(
        position: Vector2.zero(),
        size: Vector2(continentSize.x, wallThickness),
      )
        ..renderShape = true
        ..setColor(Colors.white),
    );

    // Right
    add(
      RectangleHitbox(
        position: Vector2(continentSize.x - wallThickness, 0),
        size: Vector2(wallThickness, continentSize.y),
      )
        ..renderShape = true
        ..setColor(Colors.white),
    );

    //Bottom
    add(
      RectangleHitbox(
        position: Vector2(0, continentSize.y - wallThickness),
        size: Vector2(continentSize.x, wallThickness),
      )
        ..renderShape = true
        ..setColor(Colors.white),
    );

    // Left
    add(
      RectangleHitbox(
        position: Vector2.zero(),
        size: Vector2(wallThickness, continentSize.y),
      )
        ..renderShape = true
        ..setColor(Colors.white),
    );
  }
}
