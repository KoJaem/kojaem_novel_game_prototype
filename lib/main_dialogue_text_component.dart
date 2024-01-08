import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:jenny_study/constants/customColor.dart';
import 'package:jenny_study/main.dart';

class MainDialogueTextComponent extends TextBoxComponent
    with HasGameRef<JennyGame> {
  MainDialogueTextComponent({
    super.size,
    super.textRenderer,
    super.position,
    super.boxConfig,
  });

  @override
  void drawBackground(Canvas c) {
    Rect rect = Rect.fromLTWH(0, 0, gameRef.size.x, gameRef.size.y);
    c.drawRect(rect, Paint()..color = CustomColor.white.withAlpha(90));
    super.drawBackground(c);
  }
}
