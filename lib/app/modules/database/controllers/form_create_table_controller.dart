import 'package:get/get.dart';
import 'package:mvvm_getx_pattern/app/commons/enums/database.enum.dart';
import 'package:mvvm_getx_pattern/app/models/table_meta_data.model.dart';

class FormCreateTableController extends GetxController {
  Rx<TableMetaData> table = TableMetaData(
    name: "",
    columns: [],
  ).obs;

  void addColumn() {
    table.value.columns!.add(TableColumn());
    table.refresh();
  }

  void clearTable() {
    table.value = TableMetaData(
      name: "",
      columns: [],
    );
  }

  void setTable(TableMetaData table) {
    this.table.value = table;
  }
}
