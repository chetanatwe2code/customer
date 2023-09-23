import 'package:get/get.dart';

import '../../repository/order_history_repo.dart';
import 'logic.dart';

class OrderHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderHistoryRepo(apiClient: Get.find()));
    Get.lazyPut(() => OrderHistoryLogic(orderHistoryRepo: Get.find()));
  }
}
