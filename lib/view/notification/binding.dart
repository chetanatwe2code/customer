import 'package:get/get.dart';

import '../../repository/notification_repo.dart';
import 'logic.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationRepo(apiClient: Get.find()));
    Get.lazyPut(() => NotificationLogic(repo: Get.find()));
  }
}
