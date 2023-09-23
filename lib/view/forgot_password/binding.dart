import 'package:get/get.dart';

import '../../repository/forgot_password_repo.dart';
import 'logic.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgotPasswordRepo(apiClient: Get.find()));
    Get.lazyPut(() => ForgotPasswordLogic(forgotPasswordRepo: Get.find()));
  }
}
