import 'package:get/get.dart';

import '../modules/core/bindings/core_binding.dart';
import '../modules/core/views/core_view.dart';
import '../modules/database/bindings/database_binding.dart';
import '../modules/database/views/databases_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.DATABASE;

  static final routes = [
    GetPage(
      name: Routes.CORE,
      page: () => const CoreView(),
      binding: CoreBinding(),
    ),
    GetPage(
      name: _Paths.DATABASE,
      page: () => const DatabasesView(),
      binding: DatabaseBinding(),
    ),
  ];

  AppPages._();
}
