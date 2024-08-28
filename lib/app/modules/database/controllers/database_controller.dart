import 'package:get/get.dart';
import 'package:mvvm_getx_pattern/app/commons/ui/overlays/x_snackbar.dart';
import 'package:mvvm_getx_pattern/app/models/db.model.dart';
import 'package:mvvm_getx_pattern/app/repositories/database.repository.dart';

class DatabaseController extends GetxController {
  final dbRepo = Get.find<DatabaseRepository>();
  String dbName = "";
  RxList<DatabaseModel> databases = <DatabaseModel>[].obs;
  void createDatabase() async {
    try {
      await dbRepo.createDatabase(dbName);
      XSnackBar.show(
        context: Get.context!,
        message: "Database created",
        type: SnackBarType.success,
      );
    } catch (e) {
      final error = e.toString().split(":")[1].trim();
      XSnackBar.show(
        context: Get.context!,
        message: error ?? "Error creating database",
        type: SnackBarType.error,
      );
    }
  }

  void dropDatabase(String dbName) async {
    try {
      await dbRepo.dropDatabase(dbName);
      XSnackBar.show(
        context: Get.context!,
        message: "Database dropped",
        type: SnackBarType.success,
      );
    } catch (e) {
      print(e);
      XSnackBar.show(
        context: Get.context!,
        message: "Error dropping database",
        type: SnackBarType.error,
      );
    }
  }

  void getDatabases() async {
    await dbRepo.getDatabases();
  }

  Future<int> getTableCount(String dbName) async {
    return await dbRepo.getTablesCount(dbName);
  }

  @override
  void onInit() {
    super.onInit();

    databases.bindStream(
      dbRepo.databases.stream,
    );
  }
}
