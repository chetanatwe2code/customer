import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indiakinursery/utils/string_extensions.dart';

import '../../../core/routes.dart';
import '../../../model/NotificationModel.dart';
import '../../../theme/app_colors.dart';

class NotificationView extends StatelessWidget {
  final NotificationModel? notificationModel;
  const NotificationView({Key? key , this.notificationModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(notificationModel?.notificationType == "order"){
          Get.toNamed(rsOrderPage,arguments: { "order_id" : notificationModel?.notificationTypeId });
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.whiteColor()
        ),
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text((notificationModel?.createdOn??"").toDateDMMMY(),
              style: TextStyle(
                  color: AppColors.textColor(),
                  fontSize: 10,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w300
              ),),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(notificationModel?.message??"",
                  style: TextStyle(
                    fontWeight: notificationModel?.status == "unread" ? FontWeight.bold : null,
                    color: AppColors.textColor(),
                    fontFamily: 'Inter',
                  ),),
                ),
                Icon(Icons.notifications_outlined,size: 20,
                  color: notificationModel?.status == "unread" ?
                  AppColors.textColor() :
                  AppColors.textColor().withOpacity(0.7),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
