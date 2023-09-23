import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:get/get.dart';
import 'package:indiakinursery/utils/string_extensions.dart';
import '../../../core/routes.dart';
import '../../../model/ProductModel.dart';
import '../../../theme/app_colors.dart';
import '../../../utils/price_converter.dart';
import '../../../utils/string_helper.dart';
import '../common_image.dart';
import '../common_material_button.dart';
import '../increase_decrease_buttons.dart';
import '../rating_bar.dart';
import '../toast.dart';


List<BoxShadow>? boxShadow({ Color? color, double? blurRadius,Offset? offset }){
  return [
    BoxShadow(
      color: color ?? Colors.grey.shade300,
      blurRadius: blurRadius ?? 4,
      // Shadow position
      offset: offset ?? const Offset(2, 4),
    ),
  ];
}

class ProductView extends StatelessWidget {
  final ProductModel? productModel;
  final Function()? onIncrease;
  final Function()? addToCart;
  final Function()? onDecrease;
  const ProductView({Key? key,this.productModel,this.onDecrease,this.onIncrease,this.addToCart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   String productImage = StringHelper.fistValueOfCommaSeparated(value: productModel?.coverImage ?? productModel?.allImagesUrl);
   if(productImage.isEmpty){
     productImage = StringHelper.defaultProductImage;
   }
   /// Transition
   bool isMaxLimitOver = ((productModel?.cartCount??0) >= (productModel?.productStockQuantity??0));
   bool isOutOfStock = (productModel?.productStockQuantity??0)<1;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.whiteColor(),
          boxShadow: boxShadow(),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [

          Opacity(
            opacity: isOutOfStock ? 0.5 : 1,
            child: Column(
              children: [
                InkWell(
                  onTap: (){
                    Get.toNamed(rsProductDetailPage,arguments: { "product_id" : productModel?.id ?? 0,"variant_id":productModel?.productVerientId ?? 0 });
                  },
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                        ),
                        child: CommonImage(
                          imageUrl: productImage,
                          height: 176,
                          width: double.infinity,
                          radius: 0,
                        ),
                      ),

                      /// Top-Right of image sticker-banner
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Column(
                            children: [
                              if(productModel?.isFetured?.isNotEmpty??false)...[
                                Container(
                                  decoration: const BoxDecoration(
                                      color: AppColors.featured,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(3),
                                          topRight: Radius.circular(3)
                                      )
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                                  child: Text("Featured",style: TextStyle(
                                      color: AppColors.whiteColor(),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400
                                  ),),
                                ),
                              ]
                            ],
                          ),
                        ),

                      /// Top-Left of image sticker-banner
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Column(
                            children: [
                              if((productModel?.discount??0) > 0)...[
                                Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(3),
                                          topLeft: Radius.circular(3)
                                      )
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                                  child: Text("${PriceConverter.getSingleDigit(productModel?.discount)}% OFF",style: TextStyle(
                                      color: AppColors.whiteColor(),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400
                                  ),),
                                ),
                              ]else...[
                                if(StringHelper.isWithinLast10Days(productModel?.createdOn))...[
                                  Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryColor(),
                                        borderRadius: const BorderRadius.only(
                                            bottomRight: Radius.circular(3),
                                            topLeft: Radius.circular(3)
                                        )
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                                    child: Text("new",style: TextStyle(
                                        color: AppColors.whiteColor(),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400
                                    ),),
                                  ),
                                ]
                              ],
                            ],
                          ),
                        ),

                      /// Bottom-Right of image sticker-banner
                     if((productModel?.rating??0.0) > 0)
                      Positioned(
                        right: 10,
                        bottom: 10,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: AppColors.blackColor().withOpacity(0.5),
                                  borderRadius: const BorderRadius.all(Radius.circular(3))
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                              child: Row(
                                children: [
                                  RatingBar(rating: productModel?.rating??1,starNum: 1),
                                  const SizedBox(width: 2,),
                                  Text("${productModel?.rating}",style: TextStyle(
                                      color: AppColors.whiteColor(),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400
                                  ),),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),

                const SizedBox(height: 8,),

                InkWell(
                  onTap: (){
                    Get.toNamed(rsProductDetailPage,arguments: { "product_id" : productModel?.id ?? 0,"variant_id":productModel?.productVerientId ?? 0 });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                      //   Divider(
                      //     thickness: 1.r,
                      //     height: 1.r,
                      //     color: AppColors.grayColor().withOpacity(0.2),
                      //   ),
                      // if((productModel?.rating??0) > 0)...[
                      //    8.verticalSpace,
                      //    RatingBar(rating: productModel!.rating!),
                      //  ],
                        const SizedBox(height: 8,),
                        // Text((productModel?.verientName ?? productModel?.name ?? "").toCapitalizeFirstLetter(),
                        //   maxLines: 1,
                        //   overflow: TextOverflow.ellipsis,
                        //   style: const TextStyle(
                        //     fontWeight: FontWeight.w700,
                        //     fontSize: 13,
                        //     color: AppColors.text2,
                        //     letterSpacing: -0.4,
                        //   ),
                        // ),
                        Text((productModel?.verientName ?? "").toCapitalizeFirstLetter(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            color: AppColors.text2,
                            letterSpacing: -0.4,
                          ),
                        ),
                        const SizedBox(height: 2,),
                        Text((productModel?.name ?? "").toCapitalizeFirstLetter(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 10,
                            color: AppColors.text2,
                            letterSpacing: -0.4,
                          ),
                        ),
                        const SizedBox(height: 8,),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                               if((productModel?.discount??0)>0)
                                Text(PriceConverter.removeDecimalZeroFormatWithFlag(productModel?.mrp ?? 0),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: AppColors.redColor(),
                                    decoration: TextDecoration.lineThrough,
                                    letterSpacing: -0.4,
                                  ),
                                ),
                                const SizedBox(width: 5,),
                                Text(PriceConverter.removeDecimalZeroFormatWithFlag(productModel?.price ?? 0),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: AppColors.primaryColor(),
                                    letterSpacing: -0.4,
                                  ),
                                ),
                                // Text(
                                //   '/per unit',
                                //   style: TextStyle(
                                //     fontWeight: FontWeight.w300,
                                //     fontSize: 12.sp,
                                //     color: AppColors.primaryColor(),
                                //     letterSpacing: -0.4,
                                //   ),
                                // ),
                              ],
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 8,),
                  Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if((productModel?.cartCount ?? 0) < 1)...[
                          Flexible(
                            child: CommonMaterialButton(
                              text: "AddToCart".tr,
                              iconData: FlutterRemix.shopping_basket_2_fill,
                              height: 35,
                              horizontalPadding: 10,
                              borderRadius: 5,
                              fontColor: AppColors.whiteColor(),
                              color: AppColors.cartButtonColor,
                              //color: Colors.grey.withOpacity(0.3),
                              fontWeight: FontWeight.w500,
                              isLoading: productModel?.isIncrease ?? false,
                              onTap: isOutOfStock ? null : () {
                                if(addToCart != null){
                                  addToCart!();
                                }
                              },
                            ),
                          ),
                        ]else...[
                          Expanded(
                            child: IncreaseDecreaseButtons(
                              onDecrease: isOutOfStock ? null : onDecrease,
                              isDecrease: isOutOfStock ? null : productModel?.isDecrease,
                              isIncrease: isOutOfStock ? null : productModel?.isIncrease,
                              onIncrease: isOutOfStock ? null : (
                                  isMaxLimitOver ? (){
                                    Toast.show(title: "${productModel?.verientName??0}",toastMessage: "Cart Max Reach".trParams({
                                      "stock" : "${productModel?.productStockQuantity??0}"
                                    }));
                                  } :
                                  onIncrease),
                              buttonSize: 35,
                              cartCount: productModel?.cartCount,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
              ],
            ),
          ),

         if(isOutOfStock)
          Container(
            height: 30,
            color: AppColors.ratingColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text("OUT OF STOCK",
                style: TextStyle(
                  fontSize: 10,
                  color: AppColors.whiteColor()
                ),)

              ],
            ),
          ),
        ],
      ),
    );
  }
}
