import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../models/task.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskState(tasks: [])) {
    on<LoadTasks>(_onLoadTasks);
    on<AddTask>(_onAddTask);
    on<DeleteTask>(_onDeleteTask);
    on<RefreshTasks>(_onRefreshTasks);

    add(LoadTasks());
  }

  void _onLoadTasks(LoadTasks event, Emitter<TaskState> emit) async {
    final box = Hive.box<Task>('tasks');
    final tasks = box.values.toList();
    emit(TaskState(tasks: tasks));
  }

  void _onAddTask(AddTask event, Emitter<TaskState> emit) {
    final box = Hive.box<Task>('tasks');
    box.put(event.task.id, event.task);
    emit(TaskState(tasks: box.values.toList()));
  }

  void _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) {
    final box = Hive.box<Task>('tasks');
    box.delete(event.taskId);
    emit(TaskState(tasks: box.values.toList()));
  }

  void _onRefreshTasks(RefreshTasks event, Emitter<TaskState> emit) {
    emit(TaskState(tasks: Hive.box<Task>('tasks').values.toList()));
  }
}
