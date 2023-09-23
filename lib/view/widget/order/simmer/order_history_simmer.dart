import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../theme/app_colors.dart';
import '../../small_dot.dart';

class OrderHistorySimmer extends StatelessWidget {
  const OrderHistorySimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        padding: EdgeInsets.symmetric(vertical: 15.r),
        shrinkWrap: true,
        itemBuilder: (context,index) {
          return Shimmer.fromColors(
            baseColor: AppColors.shimmerBaseColor(),
            highlightColor: AppColors.shimmerHighlightColor(),
            enabled: true,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.r,vertical: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.grayColor().withOpacity(0.3),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Container(
                          color: AppColors.grayColor().withOpacity(0.3),
                          padding: EdgeInsets.symmetric(horizontal: 10.r),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("---",
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13.sp,
                                      color: AppColors.textColor(),
                                      letterSpacing: -0.4,
                                    ),
                                  ),
                                  3.verticalSpace,
                                  Row(
                                    children: [
                                      Text("Order Id:",
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13.sp,
                                          color: AppColors.textColor(),
                                          letterSpacing: -0.4,
                                        ),
                                      ),
                                      10.horizontalSpace,
                                      Text("******",
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13.sp,
                                          color: AppColors.textColor(),
                                          letterSpacing: -0.4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              3.verticalSpace,
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "- ×",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13.sp,
                                          color: AppColors.textColor(),
                                          letterSpacing: -0.4,
                                        ),
                                      ),
                                      1.horizontalSpace,
                                      Text(
                                        "\u{20B9}---",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13.sp,
                                          color: AppColors.textColor(),
                                          letterSpacing: -0.4,
                                        ),
                                      ),
                                    ],
                                  ),
                                  5.horizontalSpace,
                                  const SmallDot(),
                                  5.horizontalSpace,
                                  const Text("---")
                                ],
                              ),

                              5.verticalSpace,

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Order Date:",  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13.sp,
                                      color: AppColors.textColor(),
                                      letterSpacing: -0.4,
                                    ),),
                                    Text("--/--/----",  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13.sp,
                                      color: AppColors.textColor(),
                                      letterSpacing: -0.4,
                                    ),),
                                  ],
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Delivery Date:",  style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13.sp,
                                        color: AppColors.textColor(),
                                        letterSpacing: -0.4,
                                      ),),
                                      Text("--/--/----",  style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13.sp,
                                        color: AppColors.textColor(),
                                        letterSpacing: -0.4,
                                      ),),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  10.verticalSpace,
                ],
              ),
            ),
          );
        }
    );
  }
}
