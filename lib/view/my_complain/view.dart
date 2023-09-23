import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indiakinursery/view/my_complain/widget/complain_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../theme/app_colors.dart';
import '../login/view.dart';
import 'logic.dart';

class MyComplainPage extends StatelessWidget {
  const MyComplainPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<MyComplainLogic>().getComplain();
    Size media = MediaQuery
        .of(context)
        .size;
    bool isSmall = !isLargeScreen(media);
    return Scaffold(
      appBar: AppBar(title: Text("My Complain".tr),),
      body: Column(
        children: [

          GetBuilder<MyComplainLogic>(
            assignId: true,
            builder: (logic) {
              return Flexible(
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
                      child: Icon(Icons.refresh, color: Theme
                          .of(context)
                          .primaryColor),
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
                     logic.refreshController.refreshCompleted();
                  },
                  onLoading: () {
                    logic.refreshController.loadComplete();
                  },
                  controller: logic.refreshController,
                  child: ListView.builder(
                    itemCount: logic.list.length,
                    padding: EdgeInsets.symmetric(vertical: isSmall ? 15 : 50,horizontal: isSmall ? 0 : 120),
                   // padding: const EdgeInsets.all(15),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return ComplainView(model: logic.list[index],);
                    },
                  ),
                ),
              );
            },
          ),

        ],
      ),
    );
  }
}
