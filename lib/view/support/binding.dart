import 'package:get/get.dart';

import 'logic.dart';

class SupportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SupportLogic(apiClient: Get.find()));
  }
}
