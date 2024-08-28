enum ColumnType {
  INTEGER,
  TEXT,
  REAL,
  BLOB,
  NUMERIC,
}

class TableColumn {
  String? name;
  ColumnType? type;
  TableColumn({this.name, this.type});
}

extension ColumnTypeExtension on ColumnType {
  String get value {
    switch (this) {
      case ColumnType.INTEGER:
        return 'INTEGER';
      case ColumnType.TEXT:
        return 'TEXT';
      case ColumnType.REAL:
        return 'REAL';
      case ColumnType.BLOB:
        return 'BLOB';
      case ColumnType.NUMERIC:
        return 'NUMERIC';
      default:
        return 'TEXT';
    }
  }
}
