import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:jenny_study/constants/customColor.dart';

class DialogueTextComponent extends TextBoxComponent {
  DialogueTextComponent(
      {super.size,
      super.textRenderer,
      super.position,
      super.boxConfig,
      super.align,
      this.bgColor});
  final Color? bgColor;

  @override
  void drawBackground(Canvas c) {
    Rect rect = Rect.fromLTWH(0, 0, size.x, size.y);
    c.drawRect(rect,
        Paint()..color = bgColor ?? CustomColor.darkBlueGray.withAlpha(150));
    super.drawBackground(c);
  }
}
