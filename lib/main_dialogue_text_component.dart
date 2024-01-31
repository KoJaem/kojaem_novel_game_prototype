import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:jenny_study/constants/customColor.dart';

class DialogueTextComponent extends TextBoxComponent {
  DialogueTextComponent({
    super.size,
    super.textRenderer,
    super.position,
    super.boxConfig,
    super.align,
    this.bgColor,
    this.customTimePerChar,
  });

  final Color? bgColor;
  final int? customTimePerChar;

  void updateText(String newText) async {
    // 텍스트 변경 시 타이핑 효과 적용
    text = ""; // 기존 텍스트 초기화
    // newText를 한 글자씩 추가하면서 timePerChar 간격으로 업데이트
    for (int i = 0; i < newText.length; i++) {
      await Future.delayed(Duration(milliseconds: customTimePerChar ?? 0), () {
        text += newText[i];
      });
    }
  }

  bool checkDialogueFinished() {
    return super.finished;
  }

  @override
  void drawBackground(Canvas c) {
    Rect rect = Rect.fromLTWH(0, 0, size.x, size.y);
    c.drawRect(rect,
        Paint()..color = bgColor ?? CustomColor.darkBlueGray.withAlpha(1));
    super.drawBackground(c);
  }
}
