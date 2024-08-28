import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mvvm_getx_pattern/app/modules/database/controllers/database_detail_controller.dart';
import 'package:mvvm_getx_pattern/app/modules/database/views/form_create_table.dart';

class DatabaseView extends GetView<DatabaseDetailController> {
  const DatabaseView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${controller.database.value.name}'),
        centerTitle: true,
      ),
      body: Obx(() {
        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            ListView.builder(
              itemCount: controller.tables.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final table = controller.tables[index];
                return ListTile(
                  dense: true,
                  leading: Icon(
                    MdiIcons.table,
                    color: Get.theme.primaryColor,
                    size: 30,
                  ),
                  visualDensity: VisualDensity.compact,
                  title: Text(
                    table.name!,
                    style: Get.textTheme.labelLarge,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            const FormCreateTable()
          ],
        );
      }),
    );
  }
}
