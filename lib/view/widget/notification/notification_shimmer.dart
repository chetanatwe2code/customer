import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../theme/app_colors.dart';

class NotificationShimmer extends StatelessWidget {
  const NotificationShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      padding: EdgeInsets.all(10.r),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Shimmer.fromColors(
          baseColor: AppColors.shimmerBaseColor(),
            highlightColor: AppColors.shimmerHighlightColor(),
            enabled: true,
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.shimmerBaseColor()
            ),
            margin: EdgeInsets.only(top: 10.r),
            padding: EdgeInsets.all(10.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("--/--/----",
                  style: TextStyle(
                      color: AppColors.textColor(),
                      fontSize: 10.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w300
                  ),),
                10.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text("###########",
                        style: TextStyle(
                          color: AppColors.textColor(),
                          fontFamily: 'Inter',
                        ),),
                    ),
                    Icon(Icons.notifications_outlined,size: 20,
                      color: AppColors.textColor().withOpacity(0.7),
                    )
                  ],
                ),
              ],
            ),
          ),);
      },
    );
  }
}
