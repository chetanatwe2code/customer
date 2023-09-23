import 'package:get/get.dart';

import 'logic.dart';

class AddReviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddReviewLogic(apiClient: Get.find()));
  }
}
