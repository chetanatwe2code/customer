import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../theme/app_colors.dart';

class HorizontalBrandShimmer extends StatelessWidget {
  final double width;
  const HorizontalBrandShimmer({Key? key,this.width=80}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: width,
      child: ListView.builder(
        itemCount: 10,
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
                    width: width,
                    height: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(width)),
                      color: AppColors.shimmerBaseColor(),
                    ),
                  ),

                  Container(
                    width: width,
                    height: width,
                    padding: EdgeInsets.all(2.r),
                    child: Center(
                      child: Text(("---"),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: AppColors.whiteColor(),
                            fontFamily: "Inter",
                            fontSize: 11.sp
                        ),textAlign: TextAlign.center,),
                    ),
                  ),


                ],
              ),
            ),
          );
        },),
    );
  }
}
