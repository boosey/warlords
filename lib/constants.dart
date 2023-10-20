import 'package:flame/game.dart';

final Vector2 worldSize = Vector2(5000, 5000);
final Vector2 castleSize = worldSize / 3;
final Vector2 lordPositionOffset = castleSize / 2;
final Vector2 lordSize = worldSize / 20;
const double wallThickness = 100;
const double brickThickness = 100;

const Map<int, int> layerConfig = {
  0: 4,
  1: 3,
  2: 2,
  3: 2,
};

final numberOfLayers = layerConfig.length;

const continentDivider = 2.75;
const straightRunLengthPercentage = 0.70009;
