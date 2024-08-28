import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mvvm_getx_pattern/app/commons/ui/inputs/x_input.dart';
import 'package:mvvm_getx_pattern/app/modules/database/widgets/database_tile.dart';

import '../controllers/database_controller.dart';

class DatabasesView extends GetView<DatabaseController> {
  const DatabasesView({super.key});
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('DATABASES'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async => controller.getDatabases(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: Get.height,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: formKey,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: XInput(
                        hintText: "Enter database name",
                        initialValue: controller.dbName,
                        onChanged: (val) {
                          controller.dbName = val;
                        },
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Please enter database name";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 6),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          controller.createDatabase();
                        }
                      },
                      child: const Text("Create"),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Obx(
                () {
                  return Text(
                    "List of database (${controller.databases.length})",
                    style: Get.textTheme.labelMedium!.copyWith(),
                  );
                },
              ),
              Expanded(
                child: Obx(
                  () {
                    return controller.databases.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                MdiIcons.databasePlusOutline,
                                size: 48,
                                color: Get.theme.primaryColor,
                              ),
                              Text(
                                "No databases found",
                                style: Get.textTheme.headlineMedium!.copyWith(
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ],
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.databases.length,
                            itemBuilder: (context, index) {
                              final db = controller.databases[index];
                              return DatabaseTile(
                                tableCountFuture:
                                    controller.getTableCount(db.name!),
                                db: db,
                                onDelete: () {
                                  controller.dropDatabase(db.name!);
                                },
                              );
                            },
                          );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
