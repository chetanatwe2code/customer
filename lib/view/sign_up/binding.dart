import 'package:get/get.dart';

import '../../repository/sign_up_repo.dart';
import 'logic.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpRepo(apiClient: Get.find()));
    Get.lazyPut(() => SignUpLogic(signUpRepo: Get.find()));
  }
}
