import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../theme/app_colors.dart';
import '../login/view.dart';
import '../widget/api_error/not_found.dart';
import '../widget/order/order_history_view.dart';
import '../widget/order/simmer/order_history_simmer.dart';
import 'logic.dart';

class OrderHistoryPage extends GetView<OrderHistoryLogic> {
  const OrderHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery
        .of(context)
        .size;
    bool isSmall = !isLargeScreen(media);
    controller.getOrder();
    return Scaffold(
      appBar: AppBar(title: Text("Order History".tr),),
      body: GetBuilder<OrderHistoryLogic>(
        assignId: true,
        builder: (logic) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: [

              if(logic.apiProcess)...[
                const Flexible(child: OrderHistorySimmer())
              ]else...[
                if(logic.list.isNotEmpty)...[
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
                        logic.getOrder();
                      },
                      onLoading: () {

                        logic.getOrder(isNextPage: true);
                      },
                      controller: logic.refreshController,
                      child: ListView.builder(
                        itemCount: logic.list.length,
                        padding: EdgeInsets.symmetric(vertical: isSmall ? 15.h : 20.h,horizontal: isSmall ? 0 : 120),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return OrderHistoryView(orderModel: logic.list[index],);
                        },
                      ),
                    ),
                  )
                ]else...[
                  (MediaQuery.of(context).size.height/3).verticalSpace,
                  const NotFound(),
                ],

              ],

            ],);
        },
      ),
    );
  }
}
