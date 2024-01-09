// 캐릭터, 배경, 대화창을 담는 용도의 컴포넌트
import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:jenny/jenny.dart';
import 'package:jenny_study/constants/customColor.dart';
import 'package:jenny_study/main.dart';
import 'package:jenny_study/main_dialogue_text_component.dart';

class ProjectViewComponent extends PositionComponent
    with DialogueView, HasGameRef<JennyGame> {
  late final TextBoxComponent mainDialogueTextComponent;
  final background = SpriteComponent();
  final girl1 = SpriteComponent();
  final girl2 = SpriteComponent();
  late final ButtonComponent forwardButtonComponent;
  Completer<void> _forwardCompleter = Completer();
  Completer<int> _choiceCompleter = Completer<int>();

  List<ButtonComponent> optionsList = [];

  @override
  FutureOr<void> onLoad() {
    final textPaint = TextPaint(
        style: const TextStyle(
      color: CustomColor.brightGray,
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

    mainDialogueTextComponent = MainDialogueTextComponent(
      size: Vector2(gameRef.size.x * .9, gameRef.size.y * .3),
      textRenderer: textPaint,
      position: Vector2(
        gameRef.size.x * .05,
        gameRef.size.y * .65,
      ),
      boxConfig: TextBoxConfig(
        maxWidth: gameRef.size.x * .9,
        margins: const EdgeInsets.all(8.0),
        growingBox: false,
        // timePerChar: 0.05,
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

  @override
  FutureOr<int?> onChoiceStart(DialogueChoice choice) async {
    _choiceCompleter = Completer<int>();
    forwardButtonComponent.removeFromParent();
    mainDialogueTextComponent.text = '';
    for (int i = 0; i < choice.options.length; i++) {
      optionsList.add(ButtonComponent(
        position: Vector2(
          gameRef.size.x * .05 + 8,
          gameRef.size.y * .1 + i * 50 + 8,
        ), // position 에 8을 더하는 이유 : `mainDialogueTextComponent` 의 margin 값
        button: TextComponent(
          text: choice.options[i].text,
          textRenderer: TextPaint(
            style: const TextStyle(
              color: CustomColor.white,
              backgroundColor: CustomColor.darkBlueGray,
              fontSize: 20,
              height: 1.4,
            ),
          ),
        ),
      ));
    }
    addAll(optionsList);
    await _getChoice(choice);

    return _choiceCompleter.future;
  }

  Future<void> _getChoice(DialogueChoice choice) async {
    return _forwardCompleter.future;
  }

  Future<void> _advance(DialogueLine line) async {
    var characterName = line.character?.name;
    var lineText = line.text;
    var dialogueText =
        characterName != null ? '$characterName: $lineText' : lineText;
    mainDialogueTextComponent.text = dialogueText;
    return _forwardCompleter.future;
  }
}
