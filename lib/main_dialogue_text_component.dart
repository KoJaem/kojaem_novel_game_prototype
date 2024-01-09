import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:jenny_study/constants/customColor.dart';

class MainDialogueTextComponent extends TextBoxComponent {
  MainDialogueTextComponent({
    super.size,
    super.textRenderer,
    super.position,
    super.boxConfig,
  });

  @override
  void drawBackground(Canvas c) {
    Rect rect = Rect.fromLTWH(0, 0, size.x, size.y);
    c.drawRect(rect, Paint()..color = CustomColor.darkBlueGray.withAlpha(90));
    super.drawBackground(c);
  }
}
