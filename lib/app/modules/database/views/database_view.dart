import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mvvm_getx_pattern/app/modules/database/controllers/database_detail_controller.dart';

class DatabaseView extends GetView<DatabaseDetailController> {
  const DatabaseView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${controller.database.value.name}'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              MdiIcons.databasePlus,
              color: Get.theme.primaryColor,
            ),
            onPressed: () {
              controller.openDatabase();
            },
          ),
          IconButton(
            icon: Icon(
              MdiIcons.tablePlus,
              color: Get.theme.primaryColor,
            ),
            onPressed: () {
              controller.createTableDialog();
            },
          ),
          IconButton(
            icon: Icon(
              MdiIcons.refresh,
              color: Get.theme.primaryColor,
            ),
            onPressed: () {
              controller.getTables();
            },
          ),
          IconButton(
            icon: Icon(
              MdiIcons.tableRemove,
              color: Get.theme.primaryColor,
            ),
            onPressed: () {
              // Implementasikan logika untuk menghapus tabel yang dipilih
              controller.dropTableDialog();
            },
          ),
        ],
      ),
      body: Obx(() {
        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.tables.length,
              itemBuilder: (context, index) {
                final table = controller.tables[index];
                return ListTile(
                  title: Text('${table.name}'),
                  subtitle: Text('Columns: ${table.columns!.length}'),
                  trailing: IconButton(
                    icon: Icon(MdiIcons.tableRemove),
                    onPressed: () {
                      controller.dropTable(table.name!);
                    },
                  ),
                );
              },
            ),
          ],
        );
      }),
    );
  }
}
