import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../theme/app_colors.dart';
import '../login/view.dart';
import '../widget/api_error/not_data.dart';
import '../widget/notification/notification_shimmer.dart';
import '../widget/notification/notification_view.dart';
import 'logic.dart';


class NotificationPage extends GetView<NotificationLogic> {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getNotification();
    Size media = MediaQuery
        .of(context)
        .size;
    bool isSmall = !isLargeScreen(media);
    return Container(
      color: AppColors.whiteColor(),
      child: Scaffold(
        backgroundColor: Colors.blueGrey.withOpacity(0.1),
        appBar: AppBar(title: Text("Notification".tr)),
        body: Column(
          children: [
            Flexible(
              child: SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                header: WaterDropHeader(
                  waterDropColor: Colors.transparent,
                  idleIcon: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: AppColors.whiteColor(),
                        shape: BoxShape.circle
                    ),
                    child: Icon(Icons.refresh,color: Theme.of(context).primaryColor),
                  ),
                ),
                footer: CustomFooter(
                  builder: (BuildContext context, LoadStatus? mode) {
                    Widget body;
                    if (mode == LoadStatus.loading) {
                      body = const CupertinoActivityIndicator();
                    } else {
                      body = Container();
                    }

                    return Container(
                      padding: const EdgeInsets.all(20),
                      child: body,
                    );
                  },
                ),
                onRefresh: () {
                  controller.getNotification();
                },
                onLoading: () {
                  controller.getNotification(isNextPage: true);
                  controller.refreshController.loadComplete();
                },
                controller: controller.refreshController,
                child: GetBuilder<NotificationLogic>(builder: (logic) {
                  return logic.apiProcess ?
                    const NotificationShimmer() :
                    logic.list.isNotEmpty ?
                    ListView.builder(
                    itemCount: logic.list.length,
                      padding: EdgeInsets.symmetric(vertical: isSmall ? 15 : 50,horizontal: isSmall ? 0 : 120),
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return NotificationView(notificationModel: logic.list[index],);
                    },
                  ) : const NoData(iconData: Icons.notifications_off,);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
