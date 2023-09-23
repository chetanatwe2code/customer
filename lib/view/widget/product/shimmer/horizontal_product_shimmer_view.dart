import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../theme/app_colors.dart';
import '../../../../utils/price_converter.dart';
import '../../rating_bar.dart';

class HorizontalProductShimmerView extends StatelessWidget {
  const HorizontalProductShimmerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.shimmerBaseColor()
      ),
      margin: EdgeInsets.only(right: 10),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.r),
                  topLeft: Radius.circular(10.r),
                ),
                child: const SizedBox(
                  height: 100,
                  width: 150,
                ),
              ),
              Positioned(
                left: 10.r,
                top: 10.r,
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.redColor().withOpacity(0.2),
                      borderRadius: BorderRadius.all(Radius.circular(3.r))
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 5.r,vertical: 2.r),
                  child: Text("Sale",style: TextStyle(
                      color: AppColors.whiteColor(),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400
                  ),),
                ),
              ),

              // Positioned(
              //   right: 10.r,
              //   top: 10.r,
              //   child: GestureDetector(
              //     child: Icon(Icons.favorite_outline,
              //       size: 20.r,
              //       color: Colors.grey.withOpacity(0.5),
              //     ),
              //   ),
              // ),
            ],
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.r,vertical: 8),
            child: Column(
              children: [
                Divider(
                  thickness: 1.r,
                  height: 1.r,
                  color: AppColors.grayColor().withOpacity(0.2),
                ),
                const RatingBar(rating: 4.5),
                8.verticalSpace,
                Text("---------",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13.sp,
                    color: AppColors.textColor().withOpacity(0.8),
                    letterSpacing: -0.4,
                  ),
                ),
                8.verticalSpace,
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(PriceConverter.removeDecimalZeroFormatWithFlag(0),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                            color: AppColors.redColor(),
                            decoration: TextDecoration.lineThrough,
                            letterSpacing: -0.4,
                          ),
                        ),
                        5.horizontalSpace,
                        Text(PriceConverter.removeDecimalZeroFormatWithFlag(0),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                            color: AppColors.primaryColor(),
                            letterSpacing: -0.4,
                          ),
                        ),
                        Text(
                          'price',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 12.sp,
                            color: AppColors.primaryColor(),
                            letterSpacing: -0.4,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
