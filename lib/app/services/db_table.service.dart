import 'package:get/get.dart';
import 'package:mvvm_getx_pattern/app/commons/enums/database.enum.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBTableService extends GetxService {
  Database? _database;
  late String _currentDbName;

  Future<void> closeDatabase() async {
    try {
      if (_database != null) {
        await _database!.close();
        _database = null;
        print('Database $_currentDbName closed successfully.');
      } else {
        print('No database is currently open.');
      }
    } catch (e) {
      print('Error closing database $_currentDbName: $e');
    }
  }

  Future<void> createTable(String tableName, List<TableColumn> columns) async {
    try {
      if (_database != null) {
        String sql = _tableCreationSQL(tableName, columns);
        await _database!.execute(sql);
        print('Table $tableName created in database $_currentDbName.');
      } else {
        print('Database $_currentDbName is not open.');
      }
    } catch (e) {
      print('Error creating table $tableName in database $_currentDbName: $e');
    }
  }

  Future<void> dropTable(String tableName) async {
    try {
      if (_database != null) {
        await _database!.execute('DROP TABLE IF EXISTS $tableName');
        print('Table $tableName dropped from database $_currentDbName.');
      } else {
        print('Database $_currentDbName is not open.');
      }
    } catch (e) {
      print(
          'Error dropping table $tableName from database $_currentDbName: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getTables() async {
    try {
      if (_database != null) {
        final result = await _database!
            .rawQuery("SELECT * FROM sqlite_master WHERE type='table';");
        print('Tables in database $_currentDbName: $result');
        return result;
      } else {
        print('Database $_currentDbName is not open.');
        return [];
      }
    } catch (e) {
      print('Error retrieving tables from database $_currentDbName: $e');
      return [];
    }
  }

  Future<int> getTablesCount(String dbName) async {
    String databasesPath = await getDatabasesPath();
    String dbPath = '$databasesPath/$dbName';

    try {
      Database db = await openDatabase(dbPath);
      final result = await db.rawQuery('''
      SELECT COUNT(*) AS table_count
      FROM sqlite_master
      WHERE type = 'table'
      ''');

      int count = result.first['table_count'] as int;
      print('Number of tables in database $dbName: $count');
      return count;
    } catch (e) {
      print('Error getting table count for database $dbName: $e');
      return 0;
    }
  }

  Future<DBTableService> init(String dbName) async {
    _currentDbName = dbName;
    try {
      print('Initializing database $_currentDbName...');
      await _openDatabase();
      print('Database $_currentDbName initialized successfully.');
      return this;
    } catch (e) {
      print('Error initializing database $_currentDbName: $e');
      rethrow; // Re-throwing exception to notify caller
    }
  }

  Future<void> _openDatabase() async {
    try {
      print('Opening database $_currentDbName...');
      String path = join(await getDatabasesPath(), _currentDbName);
      print('Database path: $path');
      _database = await openDatabase(path);
      print('Database $_currentDbName opened successfully at $path.');
    } catch (e) {
      print('Error opening database $_currentDbName: $e');
      rethrow; // Re-throwing exception to notify caller
    }
  }

  String _tableCreationSQL(String tableName, List<TableColumn> columns) {
    String columnDefinitions = columns
        .map((column) => '${column.name} ${column.type!.value}')
        .join(', ');

    return '''
    CREATE TABLE $tableName (
      id INTEGER PRIMARY KEY,
      $columnDefinitions
    )
  ''';
  }
}
