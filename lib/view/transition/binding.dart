import 'package:get/get.dart';

import 'logic.dart';

class TransitionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TransitionLogic());
  }
}
