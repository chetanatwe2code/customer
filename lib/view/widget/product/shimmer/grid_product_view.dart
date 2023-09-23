import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../theme/app_colors.dart';
import '../../common_material_button.dart';
import '../../rating_bar.dart';

class ProductShimmerView extends StatelessWidget {
  final int itemCount;
  const ProductShimmerView({Key? key,this.itemCount=4}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
        itemCount: itemCount,
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        staggeredTileBuilder: (int index) =>
        const StaggeredTile.fit(1),
        itemBuilder: (context,index) {
        return Shimmer.fromColors(
          baseColor: AppColors.shimmerBaseColor(),
          highlightColor: AppColors.shimmerHighlightColor(),
          enabled: true,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: AppColors.shimmerBaseColor()
            ),
            child: Column(
              children: [
                InkWell(
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10.r),
                          topLeft: Radius.circular(10.r),
                        ),
                        child: Container(
                          height: 126,
                        ),
                      ),
                      Positioned(
                        left: 10.r,
                        top: 10.r,
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.redColor().withOpacity(0.3),
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
                      Text("-------",
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
                              Text("--",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp,
                                  color: AppColors.redColor(),
                                  decoration: TextDecoration.lineThrough,
                                  letterSpacing: -0.4,
                                ),
                              ),
                              5.horizontalSpace,
                              Text("--",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp,
                                  color: AppColors.primaryColor(),
                                  letterSpacing: -0.4,
                                ),
                              ),
                              Text(
                                '/--',
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
                      16.verticalSpace,

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
