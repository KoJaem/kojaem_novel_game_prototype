import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

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
    add(SpriteComponent(
      sprite: backgroundSprite,
      size: size,
    ));
    add(SpriteComponent(
        sprite: girl1Sprite,
        size: Vector2(400, 400),
        position: Vector2(size.x * 0.1, size.y * 0.1)));

    add(SpriteComponent(
      sprite: girl2Sprite,
      size: Vector2(400, 400),
      position: Vector2(
        size.x * 0.9,
        size.y * 0.1,
      ),
      anchor: Anchor.topRight,
    ));

    // add(SpriteComponent(
    //   sprite: girl1Sprite,
    //   size: Vector2(468, 468),
    //   position: Vector2(
    //       (size.x * 0.5 - (468 / 2)), 0), // * 전체 width 절반 - 이미지 width 절반
    // ));
    return super.onLoad();
  }
}
