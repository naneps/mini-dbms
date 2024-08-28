import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class CRUDService extends GetxService {
  Database? _database;

  Future<void> delete(
      String tableName, String whereClause, List<dynamic> whereArgs) async {
    if (_database != null) {
      await _database!
          .delete(tableName, where: whereClause, whereArgs: whereArgs);
      print('Data deleted from $tableName');
    }
  }

  Future<void> insert(String tableName, Map<String, dynamic> values) async {
    if (_database != null) {
      await _database!.insert(tableName, values);
      print('Data inserted into $tableName');
    }
  }

  Future<List<Map<String, dynamic>>> query(String tableName) async {
    if (_database != null) {
      return await _database!.query(tableName);
    }
    return [];
  }

  void setDatabase(Database database) {
    _database = database;
  }

  Future<void> update(String tableName, Map<String, dynamic> values,
      String whereClause, List<dynamic> whereArgs) async {
    if (_database != null) {
      await _database!
          .update(tableName, values, where: whereClause, whereArgs: whereArgs);
      print('Data updated in $tableName');
    }
  }
}
