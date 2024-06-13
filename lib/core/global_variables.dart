import 'package:flutter/material.dart';
import 'package:task_assignment_app/core/enums.dart';

class Global {
  static final Global _instance = Global.internal();

  factory Global() {
    return _instance;
  }
  Global.internal();

  static String? documentsDirc;

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static Future pushScene(AppsRoute? scene,
      {bool isReplace = false,
      bool removeUntil = false,
      Map<String, dynamic>? navData,
      AppsRoute? sceneNameUntil}) {
    Future sceneRef;
    var sceneName = scene.toString();
    var untilsceneName = sceneNameUntil.toString();
    if (isReplace) {
      sceneRef = navigatorKey.currentState!
          .pushReplacementNamed(sceneName, arguments: navData);
    } else if (removeUntil) {
      sceneRef = navigatorKey.currentState!.pushNamedAndRemoveUntil(
          sceneName, ModalRoute.withName(untilsceneName),
          arguments: navData);
    } else {
      sceneRef =
          navigatorKey.currentState!.pushNamed(sceneName, arguments: navData);
    }
    return sceneRef;
  }

  static void popScene({AppsRoute? untilScene, result}) {
    if (untilScene != null) {
      navigatorKey.currentState!
          .popUntil(ModalRoute.withName(untilScene.toString()));
    } else {
      navigatorKey.currentState!.pop(result);
    }
  }
}
