import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/account_controller.dart';
import '../../controller/cart_controller.dart';
import '../../controller/checkout_logic.dart';
import '../../controller/home_controller.dart';
import '../../controller/search_controller.dart';
import '../../view/category/logic.dart';
import 'api_client.dart';
import 'api_provider.dart';

Future<void> init() async {

  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.put(sharedPreferences, permanent: true);
  Get.put(ApiClient(sharedPreferences: Get.find(),apkBaseUrl: ApiProvider.baseUrl), permanent: true);
  // Repository


  // Getx Controller And GetxService
  Get.lazyPut(() => SearchLogic(apiClient: Get.find()));
  Get.lazyPut(() => AccountLogic(apiClient: Get.find()));
  Get.lazyPut(() => HomeLogic(apiClient: Get.find()));
  Get.lazyPut(() => CategoryLogic(apiClient: Get.find()));
  Get.lazyPut(() => CheckoutLogic(apiClient: Get.find()));
  Get.lazyPut(() => CartController(apiClient: Get.find()));
}