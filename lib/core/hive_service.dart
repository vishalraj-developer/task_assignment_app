import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:task_assignment_app/models/task.dart';

import 'global_variables.dart';

class HiveService {
  initialize() async {
    final appPath = (await path.getApplicationSupportDirectory()).path;
    Global.documentsDirc = appPath + (Platform.isIOS ? '/' : '');

    Hive
      ..init(appPath)
      ..registerAdapter<Task>(TaskAdapter());
    await Hive.openBox<Task>('tasks');
  }
}
