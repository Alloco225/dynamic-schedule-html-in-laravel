import 'package:get/get.dart';

import '../controllers/main_map_controller.dart';

class MainMapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainMapController>(
      () => MainMapController(),
    );
  }
}
