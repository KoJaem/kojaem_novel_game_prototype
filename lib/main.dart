import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:jenny_study/project_view_component.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();

  runApp(GameWidget(
    game: JennyGame(),
  ));
}

class JennyGame extends FlameGame {
  late Sprite backgroundSprite;
  late Sprite girl1Sprite;
  late Sprite girl2Sprite;

  @override
  FutureOr<void> onLoad() async {
    backgroundSprite = await loadSprite('background.png');
    girl1Sprite = await loadSprite('girl1.png');
    girl2Sprite = await loadSprite('girl2.png');

    add(ProjectViewComponent());

    return super.onLoad();
  }
}
