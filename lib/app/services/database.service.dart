import 'dart:io';

import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService extends GetxService {
  Future<void> createDatabase(String dbName) async {
    final path = join(await getDatabasesPath(), dbName);

    final file = File(path);
    if (await file.exists()) {
      throw Exception('Database $dbName already exists');
    }
    try {
      await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          print('Database $dbName created');
        },
      );
    } catch (e) {
      throw Exception('Error creating database $dbName: $e');
    }
  }

  Future<void> dropDatabase(String dbName) async {
    final path = join(await getDatabasesPath(), dbName);

    // Check if the database file exists
    final file = File(path);
    if (!await file.exists()) {
      throw Exception('Database $dbName does not exist at $path');
    }

    // Attempt to delete the database file
    try {
      await file.delete();
      print('Database $dbName dropped successfully at $path');
    } catch (e) {
      throw Exception('Error dropping database $dbName: $e');
    }
  }

  Future<List<File>> getDatabasesList() async {
    String databasesPath = await getDatabasesPath();
    try {
      final List<FileSystemEntity> files = Directory(databasesPath).listSync();
      return files
          .whereType<File>()
          .where((file) => file.existsSync() && !file.path.contains('-journal'))
          .toList();
    } catch (e) {
      print('ERROR WHILE GETTING DATABASES: $e');
      return [];
    }
  }

  Future<int> getTablesCount(String dbName) async {
    String databasesPath = await getDatabasesPath();
    String dbPath = '$databasesPath/$dbName';

    try {
      // Open the database
      Database db = await openDatabase(dbPath);
      final result = await db.rawQuery('''
      SELECT COUNT(*) AS table_count
      FROM sqlite_master
      WHERE type = 'table'
      AND name NOT LIKE 'sqlite_%';
    ''');

      print(result);
      int count = Sqflite.firstIntValue(result) ?? 0;

      await db.close();

      return count;
    } catch (e) {
      print('ERROR WHILE COUNTING TABLES: $e');
      return 0;
    }
  }
}
