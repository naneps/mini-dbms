import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mvvm_getx_pattern/app/models/db.model.dart';
import 'package:mvvm_getx_pattern/app/modules/database/bindings/database_binding.dart';
import 'package:mvvm_getx_pattern/app/modules/database/views/database_view.dart';

class DatabaseTile extends StatelessWidget {
  final VoidCallback? onDelete;
  final DatabaseModel db;
  final Future<int> tableCountFuture;

  const DatabaseTile({
    super.key,
    required this.db,
    this.onDelete,
    required this.tableCountFuture,
  });

  void bottomSheetConfirmation() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            )),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Are you sure you want to delete database ${db.name}?",
              style: Get.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text("Cancel"),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.red,
                      surfaceTintColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                    ),
                    onPressed: () {
                      Get.back();
                      onDelete?.call();
                    },
                    child: const Text("Delete"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: Icon(
        MdiIcons.databaseOutline,
        color: Get.theme.primaryColor,
        size: 30,
      ),
      visualDensity: VisualDensity.compact,
      title: Text(
        db.name!,
        style: Get.textTheme.labelLarge,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<int>(
            future: tableCountFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text(
                  'Loading table count...',
                  style: Get.textTheme.bodyMedium,
                );
              } else if (snapshot.hasError) {
                return Text(
                  'Error loading table count',
                  style: Get.textTheme.bodySmall?.copyWith(color: Colors.red),
                );
              } else {
                return Text(
                  'Tables: ${snapshot.data}',
                  style: Get.textTheme.bodyMedium,
                );
              }
            },
          ),
          Text(
            db.createdAtString,
            style: Get.textTheme.bodyMedium,
          ),
        ],
      ),
      trailing: IconButton(
        icon: Icon(
          MdiIcons.trashCanOutline,
          color: Colors.red,
        ),
        onPressed: () {
          bottomSheetConfirmation();
        },
      ),
      onTap: () {
        Get.to(
          () => const DatabaseView(),
          binding: DatabaseBinding(),
          arguments: db,
          transition: Transition.rightToLeft,
        );
      },
    );
  }
}
