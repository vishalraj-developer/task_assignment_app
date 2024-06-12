import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/employee_block/employee_event.dart';
import '../blocs/task_block/task_bloc.dart';
import '../blocs/task_block/task_event.dart';
import '../blocs/employee_block/employee_bloc.dart';
import '../blocs/employee_block/employee_state.dart';
import '../models/task.dart';
import '../models/employee.dart';

class TaskFormScreen extends StatefulWidget {
  const TaskFormScreen({super.key});

  @override
  State<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    BlocProvider.of<EmployeeBloc>(context).add(LoadEmployees());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Task')),
      body: BlocBuilder<EmployeeBloc, EmployeeState>(
        builder: (context, state) {
          if (state is EmployeesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EmployeesLoaded) {
            return buildTaskForm(context, state);
          } else if (state is EmployeesError) {
            return Center(
                child: Text('Failed to load employees: ${state.message}'));
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget buildTaskForm(BuildContext context, EmployeesLoaded state) {
    bool isFallback = state.employees.any((e) => e.id != null && e.id! > 9990);

    String name = '';
    String description = '';

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Task Name'),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter some text' : null,
              onSaved: (value) => name = value!,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Task Description'),
              onSaved: (value) => description = value!,
            ),
            DropdownButtonFormField<Employee>(
              value: state.employees.first,
              onChanged: (Employee? newValue) {
                // Handle change
              },
              items: state.employees
                  .map<DropdownMenuItem<Employee>>((Employee employee) {
                return DropdownMenuItem<Employee>(
                  value: employee,
                  child: Text(employee.employeeName!),
                );
              }).toList(),
              decoration: const InputDecoration(labelText: 'Assign to'),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    var newTask = Task(
                        id: DateTime.now().toString(),
                        name: name,
                        description: description,
                        assignedTo: state.employees.first.employeeName!);
                    context.read<TaskBloc>().add(AddTask(newTask));
                    Navigator.pop(context);
                  }
                },
                child: const Text('Create Task'),
              ),
            ),
            const Spacer(),
            if (isFallback)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                      "Note: Displaying sample employees due to server limits.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
