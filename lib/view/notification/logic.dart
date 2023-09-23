import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../controller/home_controller.dart';
import '../../model/NotificationModel.dart';
import '../../repository/notification_repo.dart';

class NotificationLogic extends GetxController {
  NotificationRepo repo;
  NotificationLogic({required this.repo});


  List<NotificationModel> list = [];

  ///
  int pageSize = 10;
  int pageKey = 0;
  bool isNext = false;
  RefreshController refreshController = RefreshController(initialRefresh: false);
  ///
  bool apiProcess = true;
  getNotification({ bool isNextPage = false }){
    if(isNextPage) return;
    list.clear();
    apiProcess = true;
    repo.getNotification().then((value) => {
      value.body.forEach((v){
        list.add(NotificationModel.fromJson(v));
      }),
      Get.find<HomeLogic>().resetNotificationCount(),
      apiProcess = false,
      update(),
      refreshController.refreshCompleted(),
    }).catchError((e){
      apiProcess = false;
      update();
      refreshController.refreshCompleted();
    });
  }

}
