import 'package:flame/game.dart';

final Vector2 worldSize = Vector2(5000, 5000);
final Vector2 castleSize = worldSize / 4;
final Vector2 lordPositionOffset = castleSize / 3;
final Vector2 lordSize = worldSize / 20;
const double wallThickness = 100;
const double brickThickness = 100;
// const int numberOfHorizontalBrickRows = 5;
// const int numberOfVerticalBrickRows = numberOfHorizontalBrickRows;

const Map<int, int> layerConfig = {
  0: 5,
  1: 4,
  2: 4,
  3: 3,
};

final numberOfLayers = layerConfig.length;

const worldDivider = 3.5;
