import '../../models/employee.dart';

abstract class EmployeeState {}

class EmployeesLoading extends EmployeeState {}

class EmployeesLoaded extends EmployeeState {
  final List<Employee> employees;

  EmployeesLoaded(this.employees);
}

class EmployeesError extends EmployeeState {
  final String message;

  EmployeesError(this.message);
}
