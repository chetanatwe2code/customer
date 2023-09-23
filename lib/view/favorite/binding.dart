import 'package:get/get.dart';

import 'logic.dart';

class FavoriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavoriteLogic());
  }
}
