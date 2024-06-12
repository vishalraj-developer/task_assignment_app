import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/employee.dart';
import '../../repository/employee_repository.dart';
import 'employee_event.dart';
import 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final EmployeeRepository employeeRepository;

  EmployeeBloc({required this.employeeRepository}) : super(EmployeesLoading()) {
    on<LoadEmployees>(_onLoadEmployees);
  }

  Future<void> _onLoadEmployees(
      LoadEmployees event, Emitter<EmployeeState> emit) async {
    try {
      emit(EmployeesLoading());
      List<Employee> employees = await employeeRepository.fetchEmployees();
      emit(EmployeesLoaded(employees));
    } catch (e) {
      emit(EmployeesError(e.toString()));
    }
  }
}
