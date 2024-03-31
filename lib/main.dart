import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:jenny/jenny.dart';
import 'package:jenny_study/project_view_component.dart';

import 'constants/customColor.dart';
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

    String consultationData =
        await rootBundle.loadString('assets/yarn/consultation.yarn');

    ProjectViewComponent projectViewComponent =
        ProjectViewComponent(yarnProject);

    var dialogueRunner = DialogueRunner(
        yarnProject: yarnProject, dialogueViews: [projectViewComponent]);

    void imageChangeWithAnimation(String position, String url) async {
      switch (position) {
        case 'right':
          await projectViewComponent.rightPerson
              .add(OpacityEffect.fadeOut(EffectController(duration: 0.3)));
          Future.delayed(const Duration(milliseconds: 600), () {
            projectViewComponent.rightPerson.sprite =
                Sprite(images.fromCache(url));
            projectViewComponent.rightPerson
                .add(OpacityEffect.fadeIn(EffectController(duration: 0.3)));
          });
          break;
        case 'left':
          await projectViewComponent.leftPerson
              .add(OpacityEffect.fadeOut(EffectController(duration: 0.3)));
          Future.delayed(const Duration(milliseconds: 600), () {
            projectViewComponent.leftPerson.sprite =
                Sprite(images.fromCache(url));
            projectViewComponent.leftPerson
                .add(OpacityEffect.fadeIn(EffectController(duration: 0.3)));
          });
          break;
        case 'background':
          await projectViewComponent.background
              .add(OpacityEffect.fadeOut(EffectController(duration: 0.3)));
          Future.delayed(const Duration(milliseconds: 600), () {
            projectViewComponent.background.sprite =
                Sprite(images.fromCache(url));
            projectViewComponent.background
                .add(OpacityEffect.fadeIn(EffectController(duration: 0.3)));
          });
        default:
          break;
      }
    }

    void imageChange(String position, String url) async {
      switch (position) {
        case 'right':
          projectViewComponent.rightPerson.sprite =
              Sprite(images.fromCache(url));
          break;
        case 'left':
          projectViewComponent.leftPerson.sprite =
              Sprite(images.fromCache(url));
          break;
        case 'background':
          projectViewComponent.background.sprite =
              Sprite(images.fromCache(url));
        default:
          break;
      }
    }

    void removeText() async {
      projectViewComponent.fastCompletedMainDialogueTextComponent
          .removeFromParent();
      projectViewComponent.nameDialogueTextComponent.removeFromParent();
    }

    void removeTextBoxWithAnimation() async {
      projectViewComponent.fastCompletedMainDialogueTextComponent
          .removeFromParent();
      projectViewComponent.nameDialogueTextComponent.removeFromParent();

      await projectViewComponent.mainDialogueOverlay
          .add(OpacityEffect.fadeOut(EffectController(duration: 0.3)));
    }

    void createTextBox() async {
      await projectViewComponent.nameDialogueOverlay
          .add(OpacityEffect.fadeIn(EffectController(duration: 0.3)));

      await projectViewComponent.mainDialogueOverlay
          .add(OpacityEffect.fadeIn(EffectController(duration: 0.3)));
    }

    void changeDialogueColor(String target, String colorKey) {
      Color color = CustomColor.getColor(colorKey);
      switch (target) {
        case 'name':
          projectViewComponent.nameDialogueOverlay.bgColor = color;
          break;
        case 'conversation':
          projectViewComponent.mainDialogueOverlay.bgColor = color;
        case 'all':
        default:
          projectViewComponent.nameDialogueOverlay.bgColor = color;
          projectViewComponent.mainDialogueOverlay.bgColor = color;
          break;
      }
    }

    yarnProject
      ..commands
          .addCommand2('change_image_with_animation', imageChangeWithAnimation)
      ..commands.addCommand2('change_image', imageChange)
      ..commands.addCommand2('change_dialogue_color', changeDialogueColor)
      ..commands.addCommand0('create_textbox', createTextBox)
      ..commands.addCommand0('remove_text', removeText)
      ..commands.addCommand0(
          'remove_textbox_with_animation', removeTextBoxWithAnimation)
      ..parse(startDialogueData)
      ..parse(consultationData);

    dialogueRunner.startDialogue('start');
    add(projectViewComponent);

    return super.onLoad();
  }
}
