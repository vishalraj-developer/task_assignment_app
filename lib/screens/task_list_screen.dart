import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/task_block/task_bloc.dart';
import '../blocs/task_block/task_event.dart';
import '../blocs/task_block/task_state.dart';
import 'task_form_screen.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task List')),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state.tasks.isEmpty) {
            return const Center(child: Text("No tasks available"));
          }
          return ListView.builder(
            itemCount: state.tasks.length,
            itemBuilder: (context, index) {
              var task = state.tasks[index];
              return Card(
                child: Dismissible(
                  key: Key(task.id),
                  onDismissed: (direction) {
                    BlocProvider.of<TaskBloc>(context).add(DeleteTask(task.id));
                  },
                  background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      child: const Icon(Icons.delete, color: Colors.white)),
                  child: ListTile(
                    title: Text(task.name),
                    subtitle: Text(task.description),
                    trailing: Text(task.assignedTo),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const TaskFormScreen()));
        },
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
