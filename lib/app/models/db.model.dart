import 'dart:io';

import 'package:mvvm_getx_pattern/app/commons/utils/date_formatter.dart';

class DatabaseModel {
  final String? name;
  final String? path;
  final String? createdAt;
  final int? tableCount;

  DatabaseModel({
    this.name,
    this.path,
    this.createdAt,
    this.tableCount,
  });

  factory DatabaseModel.fromFile(File file) {
    String? createdAt;

    try {
      createdAt = file.lastModifiedSync().toString();
    } catch (e) {
      print('Error retrieving modification time for ${file.path}: $e');
      createdAt = 'Unknown';
    }

    return DatabaseModel(
      name: file.uri.pathSegments.last,
      path: file.path,
      createdAt: createdAt,
      tableCount: 0,
    );
  }
  String get createdAtString => DateFormatter().ddMMyyyyHHmm(createdAt!);

  @override
  String toString() =>
      'DatabaseModel(name: $name, path: $path, createdAt: $createdAt)';
}
