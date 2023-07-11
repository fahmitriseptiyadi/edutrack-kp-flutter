import 'package:get/get.dart';

import '../controllers/nilaiujian_controller.dart';

class NilaiujianBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NilaiujianController>(
      () => NilaiujianController(),
    );
  }
}
