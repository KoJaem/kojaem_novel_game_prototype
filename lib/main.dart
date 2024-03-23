import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:jenny/jenny.dart';
import 'package:jenny_study/test_project_view_component.dart';
// import 'package:jenny_study/project_view_component.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();

  runApp(GameWidget(
    game: JennyGame(),
  ));
}

class JennyGame extends FlameGame with TapCallbacks {
  YarnProject yarnProject = YarnProject();

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();

    String startDialogueData =
        await rootBundle.loadString('assets/yarn/start.yarn');

    String earlyMorningData =
        await rootBundle.loadString('assets/yarn/early_morning.yarn');

    String jumpTestData =
        await rootBundle.loadString('assets/yarn/jumpTest.yarn');

    ProjectViewComponent projectViewComponent =
        ProjectViewComponent(yarnProject);

    var dialogueRunner = DialogueRunner(
        yarnProject: yarnProject, dialogueViews: [projectViewComponent]);

    void imageChange(String position, String url) async {
      switch (position) {
        case 'right':
          await projectViewComponent.rightPerson
              .add(OpacityEffect.fadeOut(EffectController(duration: 0.5)));
          Future.delayed(const Duration(milliseconds: 500), () {
            projectViewComponent.rightPerson.sprite =
                Sprite(images.fromCache(url));
            projectViewComponent.rightPerson
                .add(OpacityEffect.fadeIn(EffectController(duration: 0.5)));
          });
          break;
        case 'left':
          await projectViewComponent.leftPerson
              .add(OpacityEffect.fadeOut(EffectController(duration: 0.5)));
          Future.delayed(const Duration(milliseconds: 500), () {
            projectViewComponent.leftPerson.sprite =
                Sprite(images.fromCache(url));
            projectViewComponent.leftPerson
                .add(OpacityEffect.fadeIn(EffectController(duration: 0.5)));
          });
          break;
        case 'background':
          projectViewComponent.background.sprite =
              Sprite(images.fromCache(url));
        default:
          break;
      }
    }

    void removeText() {
      projectViewComponent.fastCompletedMainDialogueTextComponent
          .removeFromParent();
    }

    yarnProject
      ..commands.addCommand2('change_image', imageChange)
      ..commands.addCommand0('remove_text', removeText)
      ..parse(startDialogueData)
      ..parse(earlyMorningData)
      ..parse(jumpTestData);

    dialogueRunner.startDialogue('start');
    add(projectViewComponent);

    return super.onLoad();
  }
}
