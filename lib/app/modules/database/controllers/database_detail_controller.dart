import 'package:get/get.dart';
import 'package:mvvm_getx_pattern/app/commons/ui/overlays/scale_dialog.dart';
import 'package:mvvm_getx_pattern/app/commons/ui/overlays/x_snackbar.dart';
import 'package:mvvm_getx_pattern/app/models/db.model.dart';
import 'package:mvvm_getx_pattern/app/models/table_meta_data.model.dart';
import 'package:mvvm_getx_pattern/app/modules/database/views/form_create_table.dart';
import 'package:mvvm_getx_pattern/app/repositories/db_table.repository.dart';

class DatabaseDetailController extends GetxController {
  Rx<DatabaseModel> database = DatabaseModel().obs;
  RxList<TableMetaData> tables = <TableMetaData>[].obs;
  final tableRepo = Get.find<DBTableRepository>();

  void createTable(TableMetaData table) async {
    try {
      await tableRepo.createTable(table.name!, table.columns!);
      getTables();
      XSnackBar.show(
        context: Get.context!,
        message: "Table created",
        type: SnackBarType.success,
      );
    } catch (e) {
      print('Error caught: $e');
      XSnackBar.show(
        context: Get.context!,
        message: e.toString().split(":")[1].trim(),
        type: SnackBarType.error,
      );
    }
  }

  void createTableDialog() {
    Get.bottomSheet(
      ScaleDialog(
        child: FormCreateTable(
          onCreateTable: (table) {
            createTable(table);
            Get.back();
          },
        ),
      ),
    );
  }

  void dropTable(String s) {}

  void dropTableDialog() {}

  void getTables() async {
    tables.value = await tableRepo.getTables(database.value.name!);
  }

  @override
  void onClose() {
    super.onClose();
    tableRepo.close();
  }

  @override
  void onInit() {
    super.onInit();
    database.value = Get.arguments;
  }

  @override
  void onReady() {
    super.onReady();
    tableRepo.init(database.value.name!).then((value) {
      getTables();
    });
  }

  void openDatabase() async {
    await tableRepo.init(database.value.name!);
    getTables();
  }
}
