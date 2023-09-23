import 'package:get/get.dart';

import '../../repository/change_password_repo.dart';
import 'logic.dart';

class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChangePasswordRepo(apiClient: Get.find()));
    Get.lazyPut(() => ChangePasswordLogic(changePasswordRepo: Get.find()));
  }
}
