import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../theme/app_colors.dart';
import '../../utils/price_converter.dart';
import '../widget/common_material_button.dart';
import '../widget/product/shimmer/horizontal_product_shimmer_view.dart';
import '../widget/rating_bar.dart';

class ProductDetailShimmer extends StatelessWidget {
  const ProductDetailShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBaseColor(),
      highlightColor: AppColors.shimmerHighlightColor(),
      enabled: true,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.r,vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                CarouselSlider.builder(
                  itemCount: 3,
                  options: CarouselOptions(
                    autoPlay: false,
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                    initialPage: 0,
                  ),
                  itemBuilder: (context, index, realIdx) {
                    return Container(
                      height: 250,
                      width: 1000,
                      color: AppColors.shimmerBaseColor(),
                    );
                  },
                ),
                Positioned(
                  bottom: -30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      for(int i = 0; i<3;i++)
                        Container(
                          width: 8.0,
                          height: 8.0,
                          margin: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: 0 == i
                                ? const Color.fromRGBO(0, 0, 0, 0.9)
                                : const Color.fromRGBO(0, 0, 0, 0.4),
                          ),
                        )
                    ],
                  ),)
              ],),

            50.verticalSpace,

            Text("######## ###",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17.sp,
                letterSpacing: -0.4,
              ),
            ),
            4.verticalSpace,
            Row(
              children: [
                Text("Brand: ",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 12.sp,
                    color: AppColors.textColor(),
                    letterSpacing: -0.4,
                  ),
                ),
                2.horizontalSpace,
                Text("#####",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 12.sp,
                    color: AppColors.textColor(),
                    letterSpacing: -0.4,
                  ),
                ),
              ],
            ),
            12.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(PriceConverter.removeDecimalZeroFormatWithFlag(0),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                        color: AppColors.redColor(),
                        decoration: TextDecoration.lineThrough,
                        letterSpacing: -0.4,
                      ),
                    ),
                    5.horizontalSpace,
                    Text(PriceConverter.removeDecimalZeroFormatWithFlag(0),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                        color: AppColors.primaryColor(),
                        letterSpacing: -0.4,
                      ),
                    ),
                    Text(
                      'price',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 15.sp,
                        color: AppColors.primaryColor(),
                        letterSpacing: -0.4,
                      ),
                    ),
                  ],
                ),
                const RatingBar(rating: 4.5,size: 20),
              ],
            ),
            16.verticalSpace,
            Row(
              children: [
                Flexible(
                  child: CommonMaterialButton(
                    text: "AddToCart".tr,
                    iconData: FlutterRemix.shopping_basket_2_fill,
                    height: 35,
                    horizontalPadding: 10,
                    borderRadius: 5,
                    fontColor: AppColors.textColor(),
                    color: Colors.grey.withOpacity(0.3),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            20.verticalSpace,

            Text("########## ######## #######  \n #### ######## #######  #\n ###",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 17.sp,
                color: AppColors.textColor(),
                letterSpacing: -0.4,
              ),
            ),

            20.verticalSpace,

            Divider(
              thickness: 1.r,
              height: 1.r,
              color: AppColors.grayColor().withOpacity(0.2),
            ),

            Padding(
              padding: EdgeInsets.all(10.r),
              child: Text("You may also like",style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp
              ),),
            ),

            SizedBox(
              height: 210,
              child: ListView.builder(
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.all(10.r),
                itemBuilder: (context, index) {
                  return const HorizontalProductShimmerView();
                },),
            ),

            10.verticalSpace,
          ],
        ),
      ),
    );
  }
}
