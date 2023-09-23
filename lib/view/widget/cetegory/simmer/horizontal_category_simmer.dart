import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../theme/app_colors.dart';

class HorizontalCategorySimmer extends StatelessWidget {
  const HorizontalCategorySimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: AppColors.shimmerBaseColor(),
            highlightColor: AppColors.shimmerHighlightColor(),
            enabled: true,
            child: Container(
              margin: EdgeInsets.only(right: 15.r),
              child: Stack(
                alignment: Alignment.center,
                children:  [

                  Container(
                    width: 140,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      color: AppColors.shimmerBaseColor(),
                    ),
                  ),

                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("--------",style: TextStyle(
                          color: AppColors.whiteColor(),
                          fontFamily: "Inter"
                      ),),
                      5.verticalSpace,
                      Text("vegetables",style: TextStyle(
                          color: AppColors.whiteColor(),
                          fontWeight: FontWeight.w100,
                          fontSize: 10.sp,
                          fontFamily: "Inter"
                      ),)
                    ],
                  ),


                ],
              ),
            ),
          );
        },),
    );
  }
}
