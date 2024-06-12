import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'blocs/employee_block/employee_bloc.dart';
import 'core/hive_service.dart';
import 'repository/employee_repository.dart';
import 'screens/task_form_screen.dart';
import 'screens/task_list_screen.dart';
import 'blocs/task_block/task_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await HiveService().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TaskBloc()),
        BlocProvider(
            create: (context) =>
                EmployeeBloc(employeeRepository: EmployeeRepository())),
      ],
      child: MaterialApp(
        title: 'Task Assignment App',
        home: const TaskListScreen(),
        routes: {
          '/create': (_) => const TaskFormScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
