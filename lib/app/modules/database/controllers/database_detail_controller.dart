import 'package:get/get.dart';
import 'package:mvvm_getx_pattern/app/models/db.model.dart';
import 'package:mvvm_getx_pattern/app/models/table_meta_data.model.dart';
import 'package:mvvm_getx_pattern/app/repositories/db_table.repository.dart';

class DatabaseDetailController extends GetxController {
  Rx<DatabaseModel> database = DatabaseModel().obs;
  RxList<TableMetaData> tables = <TableMetaData>[].obs;
  final tableRepo = Get.find<DBTableRepository>();

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
}
