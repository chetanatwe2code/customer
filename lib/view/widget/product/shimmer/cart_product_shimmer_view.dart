import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../theme/app_colors.dart';
import '../../increase_decrease_buttons.dart';

class CartProductShimmerView extends StatelessWidget {
  const CartProductShimmerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        itemCount: 5,
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
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Stack(
                          children: [
                            Container(
                              width: 100,
                              color: AppColors.shimmerBaseColor(),
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        flex: 7,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.r,vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text("---",
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13.sp,
                                        color: AppColors.textColor(),
                                        letterSpacing: -0.4,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      width: (30).r,
                                      height: (30).r,
                                      child: Icon(Icons.delete_forever,color: AppColors.redColor(),)),
                                ],
                              ),
                              5.verticalSpace,
                              Text(
                                "Unit Price - ##",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 11.sp,
                                  color: AppColors.textColor(),
                                  letterSpacing: -0.4,
                                ),
                              ),
                              16.verticalSpace,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IncreaseDecreaseButtons(onDecrease: () {  }, onIncrease: () {  },),
                                  Text(
                                    "\u{20B9}###",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.sp,
                                      color: AppColors.primaryColor(),
                                      letterSpacing: -0.4,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Divider(
                    height: 1.r,
                    thickness: 1.r,
                    color: AppColors.grayColor().withOpacity(0.3),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
