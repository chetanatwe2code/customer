import 'package:get/get.dart';

import 'logic.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderLogic(apiClient: Get.find()));
  }
}
