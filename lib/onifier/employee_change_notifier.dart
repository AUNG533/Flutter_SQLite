
import 'package:employee_book/data/local/db/app_db.dart';
import 'package:flutter/foundation.dart';

class EmployeeChangeNotifier extends ChangeNotifier {
  AppDb? _appDb;

  void initAppDb(AppDb db) {
    _appDb = db;
  }

  List<EmployeeData> _employeeListFuture = [];
  List<EmployeeData> get employeeListFuture => _employeeListFuture;
  List<EmployeeData> _employeeListStream = [];
  List<EmployeeData> get employeeListStream => _employeeListFuture;
  String _error = '';
  String get error => _error;

  void getEmployeeFuture() {
    _appDb?.getEmployees()
        .then((value) {
      _employeeListFuture = value;
    }).onError((error, stackTrace) {
      _error = error.toString();
    });
    notifyListeners();
  }

  void getEmployeeStream() {
    _appDb?.getEmployeesStream().listen((event) {
      _employeeListStream = event;
    });
    notifyListeners();
  }


}