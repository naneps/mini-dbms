import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvvm_getx_pattern/app/commons/enums/database.enum.dart';
import 'package:mvvm_getx_pattern/app/commons/theme_manager.dart';
import 'package:mvvm_getx_pattern/app/models/table_meta_data.model.dart';
import 'package:mvvm_getx_pattern/app/modules/database/controllers/form_create_table_controller.dart';

class FormCreateTable extends GetView<FormCreateTableController> {
  final Function(TableMetaData)? onCreateTable;
  const FormCreateTable({
    super.key,
    this.onCreateTable,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Get.theme.primaryColor),
      ),
      padding: const EdgeInsets.all(16),
      child: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Add New Table", style: Get.textTheme.titleLarge),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                hintText: "Enter table name",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                controller.table.value.name = value;
              },
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.table.value.columns!.length,
              itemBuilder: (context, index) {
                final column = controller.table.value.columns![index];
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: "Enter column name",
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          column.name = value;
                          controller.table.refresh();
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    DropdownButton<ColumnType>(
                      value: column.type,
                      hint: const Text("Select column type"),
                      items: ColumnType.values.map((ColumnType type) {
                        return DropdownMenuItem<ColumnType>(
                          value: type,
                          child: Text(type.value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        column.type = value;
                        controller.table.refresh();
                      },
                    ),
                    const SizedBox(height: 10),
                  ],
                );
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: ThemeManager().blackColor,
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.grey.shade600),
                fixedSize: Size(Get.width, 40),
              ),
              child: const Text("Add Column"),
              onPressed: () {
                controller.addColumn();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(Get.width, 40),
              ),
              child: const Text("Create"),
              onPressed: () {
                onCreateTable?.call(controller.table.value);
              },
            ),
          ],
        );
      }),
    );
  }
}
