import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/employee.dart';

class EmployeeRepository {
  final String baseUrl = "https://dummy.restapiexample.com/api/v1";

  final List<Employee> _sampleEmployees = [
    Employee(
        id: 9991,
        employeeName: "John Doe",
        employeeSalary: 50000,
        employeeAge: 30,
        profileImage: ""),
    Employee(
        id: 9992,
        employeeName: "Jane Smith",
        employeeSalary: 52000,
        employeeAge: 40,
        profileImage: ""),
    Employee(
        id: 9993,
        employeeName: "Bob Johnson",
        employeeSalary: 55000,
        employeeAge: 20,
        profileImage: ""),
  ];

  Future<List<Employee>> fetchEmployees() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/employees'));

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);

        return List<Employee>.from(
            body["data"].map((x) => Employee.fromJson(x)));
      } else if (response.statusCode == 429) {
        return _sampleEmployees;
      } else {
        throw "Failed to load employees: Status code ${response.statusCode}";
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching employees: $e');
      }
      throw e.toString().replaceFirst('Exception: ', '');
    }
  }
}
