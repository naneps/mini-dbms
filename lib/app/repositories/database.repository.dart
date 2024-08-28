import 'package:get/get.dart';
import 'package:mvvm_getx_pattern/app/models/db.model.dart';
import 'package:mvvm_getx_pattern/app/services/database.service.dart';

class DatabaseRepository extends GetxService {
  final DatabaseService dbService = Get.find<DatabaseService>();

  RxList<DatabaseModel> databases = <DatabaseModel>[].obs;

  Future<void> createDatabase(String dbName) async {
    await dbService.createDatabase(dbName);
    await getDatabases();
  }

  Future<void> dropDatabase(String dbName) async {
    await dbService.dropDatabase(dbName);
    await getDatabases();
  }

  Future<void> getDatabases() async {
    try {
      final dbFiles = await dbService.getDatabasesList();

      databases.value = dbFiles.map((file) {
        return DatabaseModel.fromFile(file);
      }).toList();
      print(databases);
    } catch (e) {
      print('ERROR WHILE FETCHING DATABASES: $e');
    }
  }

  Future<int> getTablesCount(String dbName) {
    return dbService.getTablesCount(dbName);
  }

  @override
  void onInit() {
    super.onInit();
    getDatabases();
  }
}
