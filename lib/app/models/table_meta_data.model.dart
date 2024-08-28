import 'package:mvvm_getx_pattern/app/commons/enums/database.enum.dart';

class TableMetaData {
  final String? type;
  String? name;
  final String? tblName;
  final int? rootPage;
  final List<TableColumn>? columns;
  final String? sql;

  TableMetaData({
    this.type,
    this.name,
    this.tblName,
    this.rootPage,
    this.columns,
    this.sql,
  });

  // Factory method to create an instance from a map (e.g., from JSON)
  factory TableMetaData.fromMap(Map<String, dynamic> map) {
    return TableMetaData(
      type: map['type'] as String,
      name: map['name'] as String,
      tblName: map['tbl_name'] as String,
      rootPage: map['rootpage'] as int,
      sql: map['sql'] as String,
    );
  }

  // Method to convert the instance to a map (e.g., for JSON serialization)
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'name': name,
      'tbl_name': tblName,
      'rootpage': rootPage,
      'sql': sql,
    };
  }

  @override
  String toString() {
    return 'TableMetaData(type: $type, name: $name, tblName: $tblName, rootPage: $rootPage, sql: $sql)';
  }
}
