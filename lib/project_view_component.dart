// 캐릭터, 배경, 대화창을 담는 용도의 컴포넌트
import 'dart:async';

import 'package:flame/components.dart';
import 'package:jenny/jenny.dart';
import 'package:jenny_study/main.dart';

class ProjectViewComponent extends PositionComponent
    with DialogueView, HasGameRef<JennyGame> {
  final background = SpriteComponent();
  final girl1 = SpriteComponent();
  final girl2 = SpriteComponent();

  @override
  FutureOr<void> onLoad() {
    background
      ..sprite = gameRef.backgroundSprite
      ..size = gameRef.size;

    girl1
      ..sprite = gameRef.girl1Sprite
      ..size = Vector2(400, 400)
      ..position = Vector2(gameRef.size.x * 0.01, gameRef.size.y * 0.1);

    girl2
      ..sprite = gameRef.girl2Sprite
      ..size = Vector2(400, 400)
      ..position = Vector2(gameRef.size.x * 0.99, gameRef.size.y * 0.1)
      ..anchor = Anchor.topRight;

    addAll([background, girl1, girl2]);
    return super.onLoad();
  }
}
