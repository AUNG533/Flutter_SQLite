
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
  List<EmployeeData> get employeeListStream => _employeeListStream;
  EmployeeData? _employeeData;
  EmployeeData? get employeeData => _employeeData;
  String _error = '';
  String get error => _error;
  bool _isAdded = false;
  bool get isAdded => _isAdded;
  bool _isUpdating = false;
  bool get isUpdating => _isUpdating;
  bool _isDeleting = false;
  bool get isDeleting => _isDeleting;

  // Get the list of employees
  void getEmployeeFuture() {
    _appDb?.getEmployees()
        .then((value) {
      _employeeListFuture = value;
    }).onError((error, stackTrace) {
      _error = error.toString();
    });
    notifyListeners();
  }

  // Get employee list from stream
  void getEmployeeStream() {
    _appDb?.getEmployeesStream().listen((event) {
      _employeeListStream = event;
    });
    notifyListeners();
  }

  // Get Single Employee
  void getSingleEmployee(int id){
    _appDb?.getEmployee(id)
        .then((value) {
      _employeeData = value;
    }).onError((error, stackTrace) {
      _error = error.toString();
    });
    notifyListeners();
  }

  // Create Employee
  void createEmployee(EmployeeCompanion entity) {
   _appDb?.insertEmployee(entity)
        .then((value) {
      _isAdded = value >= 1 ? true : false;
    }).onError((error, stackTrace) {
      _error = error.toString();
    });
    notifyListeners();
  }

  // update Employee
  void updateEmployee(EmployeeCompanion entity) {
    _appDb?.updateEmployee(entity)
        .then((value) {
        _isUpdating = value;
    }).onError((error, stackTrace) {
      _error = error.toString();
    });
    notifyListeners();
  }

  // delete Employee
  void deleteEmployee(int id) {
    _appDb?.deleteEmployee(id).then((value) {
      _isDeleting = value == 1 ? true : false;
    }).onError((error, stackTrace) {
      _error = error.toString();
    });
    notifyListeners();
  }
}