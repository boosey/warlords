import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';
import 'package:warlords/warlords_game.dart';

void main() {
  final game = WarlordsGame();
  runApp(GameWidget(game: game));
}
