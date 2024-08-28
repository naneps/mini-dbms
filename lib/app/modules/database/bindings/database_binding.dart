import 'package:get/get.dart';

import 'package:mvvm_getx_pattern/app/modules/database/controllers/database_detail_controller.dart';
import 'package:mvvm_getx_pattern/app/modules/database/controllers/form_create_table_controller.dart';
import 'package:mvvm_getx_pattern/app/repositories/database.repository.dart';
import 'package:mvvm_getx_pattern/app/repositories/db_table.repository.dart';
import 'package:mvvm_getx_pattern/app/services/database.service.dart';
import 'package:mvvm_getx_pattern/app/services/db_table.service.dart';

import '../controllers/database_controller.dart';

class DatabaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FormCreateTableController>(
      () => FormCreateTableController(),
    );
    Get.lazyPut(() => DatabaseDetailController());
    Get.lazyPut(() => DatabaseController());
    Get.lazyPut(() => DatabaseRepository());
    Get.lazyPut(() => DBTableRepository());
    Get.lazyPut(() => DatabaseService());
    Get.lazyPut(() => DBTableService());
  }
}
