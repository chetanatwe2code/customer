import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:indiakinursery/utils/string_extensions.dart';

import '../../../core/routes.dart';
import '../../../model/OrderDetailsModel.dart';
import '../../../theme/app_colors.dart';
import '../../../utils/assets.dart';
import '../../../utils/price_converter.dart';
import '../../../utils/string_helper.dart';
import '../../widget/common_image.dart';
import '../../widget/product/grid_product_view.dart';

class OrderProduct extends StatefulWidget {
  final OrderProductDetaile? model;
  final String? orderStatus;
  const OrderProduct({Key? key,this.model,this.orderStatus}) : super(key: key);

  @override
  State<OrderProduct> createState() => _OrderProductState();
}

class _OrderProductState extends State<OrderProduct> {

  bool showRating = false;

  @override
  Widget build(BuildContext context) {
   String productImage = StringHelper.fistValueOfCommaSeparated(value:
   widget.model?.coverImage ??
       widget.model?.allImagesUrl ??
       StringHelper.defaultProductImage);
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.whiteColor(),
          boxShadow: boxShadow(),
        ),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          CommonImage(
            imageUrl: productImage,
            width: 90,
            height: 90,
            radius: 5,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text((widget.model?.verientName ?? "")
                    .toCapitalizeFirstLetter(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp,
                    color: AppColors.textColor(),
                    letterSpacing: -0.4,
                  ),
                ),

                createRow(title: "Price ",
                    value: "\u{20B9}${PriceConverter.removeDecimalZeroFormat((widget.model?.price??0)*(widget.model?.orderCartCount??1))}",
                    subValue: "${widget.model?.orderCartCount} × \u{20B9}${(widget.model?.price ?? 0)}"),

                if((widget.model?.gst??0)>0)
                  createRow(title: "GST ",
                      value: "\u{20B9}${PriceConverter.getGst(gst: widget.model?.gst,price: widget.model?.price,count: widget.model?.orderCartCount)}",
                      subValue: "${widget.model?.gst}%"),

                //
                // if((widget.model?.gst??0)>0)
                //   createRow(title: "GST ",
                //       value: "\u{20B9}${PriceConverter.removeDecimalZeroFormat((((widget.model?.price??0)*(widget.model?.gst??0))/100)*(widget.model?.orderCartCount??0))}",
                //       subValue: "${PriceConverter.getSingleDigit((widget.model?.gst ?? 0),)}%"),


                10.verticalSpace,

                if(widget.orderStatus == "Delivered")
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    InkWell(
                      onTap: (){
                        Get.toNamed(rsAddReviewPage,arguments: { "product" : widget.model?.toJson() });
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 1),
                        child: Text("Submit Review",
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.whiteColor(),
                            fontWeight: FontWeight.bold
                          ),),
                      ),
                    ),

                    // 10.horizontalSpace,
                    //
                    //
                    // RatingBar.builder(
                    //   initialRating: 0,
                    //   minRating: 0,
                    //   direction: Axis.horizontal,
                    //   allowHalfRating: true,
                    //   itemCount: 5,
                    //   itemSize: 17,
                    //   itemPadding: EdgeInsets.zero,
                    //   itemBuilder: (context, _) =>
                    //   const Icon(
                    //     Icons.star,
                    //     color: AppColors.ratingColor,
                    //   ),
                    //   onRatingUpdate: (rating) {
                    //     Get.toNamed(rsAddReviewPage,arguments: { 'rating': rating , "product" : widget.model?.toJson() });
                    //   },
                    // ),
                  ],
                ),

              ],
            ),
          ),
        ],
      )
    );
  }
  createRow({required String title ,required String value, String? subValue }){
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [

          SizedBox(
            width: 65,
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 13,
                color: AppColors.textColor(),
                letterSpacing: -0.4,
              ),
            ),
          ),

          SizedBox(
            child: Text(
              ":-",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 13,
                color: AppColors.textColor(),
                letterSpacing: -0.4,
              ),
            ),
          ),

          const SizedBox(width: 10,),

          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: AppColors.primaryColor(),
              letterSpacing: -0.4,
            ),
          ),

          if(subValue?.isNotEmpty??false)...[
            const SizedBox(width: 5,),
            SizedBox(
              child: Text(
                "($subValue)",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: AppColors.textColor(),
                  letterSpacing: -0.4,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
