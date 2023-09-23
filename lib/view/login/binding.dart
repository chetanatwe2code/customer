import 'package:get/get.dart';

import '../../repository/login_repo.dart';
import 'logic.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginRepo(apiClient: Get.find()));
    Get.lazyPut(() => LoginLogic(loginRepo: Get.find<LoginRepo>()));
  }
}
