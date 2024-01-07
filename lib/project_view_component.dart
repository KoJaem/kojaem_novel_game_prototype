// 캐릭터, 배경, 대화창을 담는 용도의 컴포넌트
import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:jenny/jenny.dart';
import 'package:jenny_study/constants/customColor.dart';
import 'package:jenny_study/main.dart';

class ProjectViewComponent extends PositionComponent
    with DialogueView, HasGameRef<JennyGame> {
  late final TextBoxComponent mainDialogueTextComponent;
  final background = SpriteComponent();
  final girl1 = SpriteComponent();
  final girl2 = SpriteComponent();
  late final ButtonComponent forwardButtonComponent;
  Completer<void> _forwardCompleter = Completer();

  @override
  FutureOr<void> onLoad() {
    final dialogPaint = TextPaint(
        style: const TextStyle(
      color: CustomColor.white,
      backgroundColor: CustomColor.darkBlueGray,
      fontSize: 20,
      height: 1.4,
    ));
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

    forwardButtonComponent = ButtonComponent(
        button: PositionComponent(),
        size: gameRef.size,
        onPressed: () {
          if (!_forwardCompleter.isCompleted) {
            _forwardCompleter.complete();
          }
        });

    mainDialogueTextComponent = TextBoxComponent(
      text: '',
      textRenderer: dialogPaint,
      position: Vector2(
        gameRef.size.x * .05,
        gameRef.size.y * .65,
      ),
      boxConfig: TextBoxConfig(
        maxWidth: gameRef.size.x * .9,
      ),
    );
    addAll([
      background,
      girl1,
      girl2,
      forwardButtonComponent,
      mainDialogueTextComponent,
    ]);
    return super.onLoad();
  }

  @override
  FutureOr<bool> onLineStart(DialogueLine line) async {
    _forwardCompleter = Completer();
    await _advance(line);
    return super.onLineStart(line);
  }

  Future<void> _advance(DialogueLine line) async {
    var characterName = line.character?.name;
    var lineText = line.text;
    var dialogueText =
        characterName != null ? '$characterName: $lineText' : lineText;
    mainDialogueTextComponent.text = dialogueText;
    debugPrint('debug: $dialogueText');
    return _forwardCompleter.future;
  }
}
