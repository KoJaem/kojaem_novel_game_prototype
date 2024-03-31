import 'dart:ui';

import 'package:flame/components.dart';
import 'package:kojaem_novel_game_prototype/constants/customColor.dart';
import 'package:kojaem_novel_game_prototype/provider/hasOpacityProvider.dart';

class DialogueOverlay extends PositionComponent with HasOpacityProvider {
  DialogueOverlay({
    super.size,
    super.position,
    super.anchor,
    super.angle,
    super.children,
    super.priority,
    super.scale,
    this.bgColor,
  });

  Color? bgColor;

  @override
  void render(Canvas canvas) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.x, size.y),
      Paint()
        ..color =
            bgColor?.withAlpha(150) ?? CustomColor.darkBlueGray.withAlpha(150),
    );
  }
}
