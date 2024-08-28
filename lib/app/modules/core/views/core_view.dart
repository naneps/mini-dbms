import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/core_controller.dart';

class CoreView extends GetView<CoreController> {
  const CoreView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CoreView'),
        centerTitle: true,
      ),
      body: const Column(
        children: [],
      ),
    );
  }
}
