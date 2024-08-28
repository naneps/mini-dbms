import 'package:get/get.dart';
import 'package:mvvm_getx_pattern/app/commons/enums/database.enum.dart';
import 'package:mvvm_getx_pattern/app/models/table_meta_data.model.dart';
import 'package:mvvm_getx_pattern/app/services/db_table.service.dart';

class DBTableRepository {
  final dbTableService = Get.find<DBTableService>();
  List<TableMetaData> tables = [];
  Future<void> close() async {
    try {
      await dbTableService.closeDatabase();
    } catch (e) {
      print('Error closing database: $e');
    }
  }

  Future<void> createTable(String tableName, List<TableColumn> columns) async {
    try {
      await dbTableService.createTable(tableName, columns);
    } catch (e) {
      print('Error creating table $tableName: $e');
    }
  }

  Future<void> dropTable(String tableName) async {
    try {
      await dbTableService.dropTable(tableName);
    } catch (e) {
      print('Error dropping table $tableName: $e');
    }
  }

  Future<int> getTableCount(String dbName) async {
    try {
      return await dbTableService.getTablesCount(dbName);
    } catch (e) {
      print('Error getting table count for $dbName: $e');
      return 0;
    }
  }

  Future<List<TableMetaData>> getTables(String dbName) async {
    try {
      final result = await dbTableService.getTables();
      return result.map((table) {
        return TableMetaData.fromMap(table);
      }).toList();
    } catch (e) {
      print('Error getting tables for $dbName: $e');
      return [];
    }
  }

  Future<void> init(String dbName) async {
    try {
      print('Initializing database: $dbName');
      await dbTableService.init(dbName);
    } catch (e) {
      print('Error initializing database $dbName: $e');
    }
  }
}
