import 'package:flutter/material.dart';
import 'package:task_assignment_app/core/enums.dart';

import '../screens/task_form_screen.dart';
import '../screens/task_list_screen.dart';

Widget? _getRoute(String sceneName, dynamic navData) {
  final route =
      AppsRoute.values.firstWhere((element) => element.toString() == sceneName);
  switch (route) {
    case AppsRoute.taskFormScreen:
      return const TaskFormScreen();
    case AppsRoute.taskListScreen:
      return const TaskListScreen();
    default:
      return null;
  }
}

Route<dynamic>? generateRoute(RouteSettings settings) {
  final navData = settings.arguments;
  final sceneName = settings.name;
  final route = _getRoute(sceneName!, navData);
  return route == null ? null : MaterialPageRoute(builder: (_) => route);
}
