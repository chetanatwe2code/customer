import 'package:get/get.dart';

import 'logic.dart';

class MyComplainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyComplainLogic(apiClient: Get.find()));
  }
}
