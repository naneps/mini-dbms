import 'package:mvvm_getx_pattern/app/commons/enums/database.enum.dart';

class TableMetaData {
  String? type;
  String? name;
  String? tblName;
  int? rootPage;
  String? sql;
  List<TableColumn>? columns;

  TableMetaData({
    this.type,
    this.name,
    this.tblName,
    this.rootPage,
    this.sql,
    this.columns,
  });

  factory TableMetaData.fromMap(Map<String, dynamic> map) {
    String sql = map['sql'] as String;
    List<TableColumn> columns = [];

    // Parse the SQL to extract column definitions
    if (sql.contains('CREATE TABLE')) {
      final regex = RegExp(r'CREATE TABLE.*?\((.*)\)', dotAll: true);
      final match = regex.firstMatch(sql);

      if (match != null) {
        final columnDefs = match.group(1)!.split(',');
        for (var columnDef in columnDefs) {
          final columnParts = columnDef.trim().split(RegExp(r'\s+'));
          final columnName = columnParts[0];
          final columnType = columnParts[1];
          final isPrimaryKey = columnDef.contains('PRIMARY KEY');
          final isNullable = !columnDef.contains('NOT NULL');

          columns.add(TableColumn(
            name: columnName,
            type: ColumnTypeExtension(ColumnType.TEXT).fromValue(columnType),
          ));
        }
      }
    }

    return TableMetaData(
      type: map['type'] as String,
      name: map['name'] as String,
      tblName: map['tbl_name'] as String,
      rootPage: map['rootpage'] as int,
      sql: sql,
      columns: columns,
    );
  }
}
