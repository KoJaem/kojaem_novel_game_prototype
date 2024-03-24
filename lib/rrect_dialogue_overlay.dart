import 'dart:ui';

import 'package:flame/components.dart';
import 'package:jenny_study/constants/customColor.dart';

class RRectDialogueOverlay extends PositionComponent {
  RRectDialogueOverlay({
    super.size,
    super.position,
    this.bgColor,
  });
  Color? bgColor;

  @override
  void render(Canvas canvas) {
    const radius = 20.0; // 둥근 모서리의 반경

    final rRect = RRect.fromLTRBR(
      0, // left
      0, // top
      size.x, // right
      size.y, // bottom
      const Radius.circular(radius), // 둥근 모서리 반경 설정
    );

    canvas.drawRRect(
      rRect,
      Paint()
        ..color =
            bgColor?.withAlpha(150) ?? CustomColor.darkBlueGray.withAlpha(150),
    );
  }
}
