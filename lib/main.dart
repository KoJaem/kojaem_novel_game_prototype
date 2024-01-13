import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:jenny/jenny.dart';
import 'package:jenny_study/project_view_component.dart';

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
  ProjectViewComponent projectViewComponent = ProjectViewComponent();

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();

    String startDialogueData =
        await rootBundle.loadString('assets/yarn/start.yarn');

    String earlyMorningData =
        await rootBundle.loadString('assets/yarn/early_morning.yarn');

    String jumpTestData =
        await rootBundle.loadString('assets/yarn/jumpTest.yarn');

    yarnProject
      ..parse(startDialogueData)
      ..parse(earlyMorningData)
      ..parse(jumpTestData);

    var dialogueRunner = DialogueRunner(
        yarnProject: yarnProject, dialogueViews: [projectViewComponent]);

    dialogueRunner.startDialogue('start');
    add(projectViewComponent);

    return super.onLoad();
  }
}
