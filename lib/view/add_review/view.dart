import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:indiakinursery/theme/app_colors.dart';
import 'package:indiakinursery/view/widget/common_material_button.dart';
import 'package:indiakinursery/view/widget/input_field/common_input_field.dart';

import '../../utils/assets.dart';
import '../../utils/string_helper.dart';
import '../widget/common_image.dart';
import 'logic.dart';

class AddReviewPage extends GetView<AddReviewLogic> {
  const AddReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    String productImage = StringHelper.fistValueOfCommaSeparated(
        value: controller.product?.coverImage ??
            controller.product?.allImagesUrl);
    if (productImage.isEmpty) {
      productImage = StringHelper.defaultProductImage;
    }
    return Scaffold(
      appBar: AppBar(title: Text("Rating & Review".tr),),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            20.verticalSpace,

            Row(
              children: [

                CommonImage(
                  imageUrl: productImage,
                  width: 50,
                  height: 50,
                  radius: 50,
                  assetPlaceholder: appProductDemo,
                ),

                10.horizontalSpace,
                GetBuilder<AddReviewLogic>(
                  assignId: true,
                  builder: (logic) {
                    return Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text((logic.product?.verientName ?? ""),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,),
                          5.verticalSpace,
                          Row(
                            children: [
                              RatingBar.builder(
                                initialRating: logic.rating ?? 0.0,
                                minRating: 0,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 24,
                                itemPadding: EdgeInsets.zero,
                                itemBuilder: (context, _) =>
                                const Icon(
                                  Icons.star,
                                  color: AppColors.ratingColor,
                                ),
                                onRatingUpdate: (rating) {
                                  logic.rating = rating;
                                  logic.update();
                                },
                              ),

                              if((logic.rating??0) > 0)
                              Text("(${logic.rating})")
                            ],
                          ),

                        ],
                      ),
                    );
                  },
                ),

              ],
            ),

            35.verticalSpace,

            Text("Write a Review", style: TextStyle(
                fontSize: 15.sp,
                color: AppColors.textColor(),
                fontWeight: FontWeight.w500
            ),),

            10.verticalSpace,

            CommonInputField(
              maxLine: 5,
              textController: controller.commentController,
            ),

            40.verticalSpace,

            GetBuilder<AddReviewLogic>(
              assignId: true,
              builder: (logic) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    CommonMaterialButton(
                      text: "Skip for review",
                      height: 40,
                      fontSize: 13,
                      color: AppColors.darkPrimary.withOpacity(0.1),
                      fontColor: AppColors.darkPrimary,
                      isLoading: logic.isSubmitting && !logic.withReview,
                      onTap: () {
                        logic.withReview = false;
                        logic.submitReview();
                      },
                    ),

                    CommonMaterialButton(
                      text: "Submit",
                      height: 40,
                      fontSize: 13,
                      isLoading: logic.isSubmitting && logic.withReview,
                      isEnable: !logic.isSubmitting,
                      color: AppColors.primary,
                      fontColor: AppColors.whiteColor(),
                      onTap: () {
                        logic.withReview = true;
                        logic.submitReview();
                      },
                    ),

                  ],
                );
              },
            )

          ],
        ),
      ),
    );
  }
}
