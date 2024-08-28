import 'package:get/get.dart';
import 'package:mvvm_getx_pattern/app/repositories/database.repository.dart';
import 'package:mvvm_getx_pattern/app/services/database.service.dart';

import '../controllers/core_controller.dart';

class CoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CoreController>(() => CoreController());
    Get.lazyPut(() => DatabaseService());
    Get.lazyPut(() => DatabaseRepository());
  }
}
