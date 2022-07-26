
import 'dart:core';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:employee_book/data/local/entity/employee_entity.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

part 'app_db.g.dart'; //  flutter pub run build_runner build --delete-conflicting-outputs

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'employee.sqlite'));

    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Employee])
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Get the list of employees
  Future<List<EmployeeData>> getEmployees() async {
    return await select(employee).get();
  }

  // Get the employee Stream
  Stream<List<EmployeeData>> getEmployeesStream() {
    // return select(employee).watch();
    return select(employee).get().asStream();
  }

  // Get the employee by id
  Future<EmployeeData> getEmployee(int id) async {
    return await (select(employee)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  // update the employee
  Future<bool> updateEmployee(EmployeeCompanion entity) async {
    return await update(employee).replace(entity);
  }

  // insert the employee
  Future<int> insertEmployee(EmployeeCompanion entity) async {
    return await into(employee).insert(entity);
  }

  // delete the employee
  Future<int> deleteEmployee(int id) async {
    return await (delete(employee)..where((tbl) => tbl.id.equals(id))).go();
  }
}
