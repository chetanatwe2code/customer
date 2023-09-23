import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:get/get.dart';
import 'package:indiakinursery/utils/string_extensions.dart';
import 'package:indiakinursery/view/widget/product/grid_product_view.dart';

import '../../../core/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../model/ProductModel.dart';
import '../../../utils/price_converter.dart';
import '../../../utils/string_helper.dart';
import '../common_image.dart';
import '../common_material_button.dart';
import '../increase_decrease_buttons.dart';
import '../rating_bar.dart';
import '../toast.dart';

class HorizontalProductView extends StatelessWidget {
  final ProductModel? productModel;
  final bool formHome;
  final bool isLargeScreen;
  final double width;
  final double height;
  final Function()? onIncrease;
  final Function()? addToCart;
  final Function()? onDecrease;
  const HorizontalProductView({Key? key,this.productModel,
    this.formHome = false,
    this.isLargeScreen = false,
    this.onIncrease,
    this.onDecrease,
    this.addToCart,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLargeScreen ? _buildLargeScreen() : _buildSmallScreen();
  }
  Widget _buildLargeScreen(){
    String productImage = StringHelper.fistValueOfCommaSeparated(value: productModel?.coverImage ?? productModel?.allImagesUrl);
    if(productImage.isEmpty){
      productImage = StringHelper.defaultProductImage;
    }
    bool isMaxLimitOver = ((productModel?.cartCount??0) >= (productModel?.productStockQuantity??0));
    bool isOutOfStock = ((productModel?.productStockQuantity??0)<1);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.whiteColor(),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 1,
              offset: Offset(0, 1), // Shadow position
            ),
          ]
      ),
      width: width,
      height: height,
      margin: const EdgeInsets.only(left: 8,right: 20,bottom: 5),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Opacity(
            opacity: isOutOfStock ? 0.5 : 1,
            child: Column(
              children: [

                // image not fit in width
                SizedBox(
                  height: 196,
                  child: InkWell(
                    onTap: (){
                      if(formHome){
                        Get.toNamed(rsProductDetailPage,arguments: { "product_id" : productModel?.id ?? 0,"variant_id":productModel?.productVerientId ?? 0,"from_home" : true },preventDuplicates: false);
                      }else{
                        Get.offNamed(rsProductDetailPage,arguments: { "product_id" : productModel?.id ?? 0,"variant_id":productModel?.productVerientId ?? 0 },preventDuplicates: false);
                      }
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
                            height: 196,
                            width: double.infinity,
                            fit: BoxFit.cover,
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
                                      RatingBar(rating: productModel?.rating??1,starNum: 1,size: 13,),

                                      const SizedBox(width: 2,),
                                      Text("${productModel?.rating}",style: TextStyle(
                                          color: AppColors.whiteColor(),
                                          fontSize: 10,
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
                ),

                const Spacer(),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [

                      Text((productModel?.verientName ?? "").toCapitalizeFirstLetter(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
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
                          fontSize: 13,
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
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: AppColors.redColor(),
                                    decoration: TextDecoration.lineThrough,
                                    letterSpacing: -0.4,
                                  ),
                                ),
                              const SizedBox(width: 5,),
                              Text(PriceConverter.removeDecimalZeroFormatWithFlag(productModel?.price ?? 0),
                                maxLines: 1,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: AppColors.primaryColor(),
                                  letterSpacing: -0.4,
                                ),
                              ),
                              // Text(
                              //   'price',
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

                      const SizedBox(height: 8,),
                      if(!((productModel?.quantity??0)<0))
                        SizedBox(
                          width: width,
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

                const Spacer(),
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

  Widget _buildSmallScreen(){
    String productImage = StringHelper.fistValueOfCommaSeparated(value: productModel?.coverImage ?? productModel?.allImagesUrl);
    if(productImage.isEmpty){
      productImage = StringHelper.defaultProductImage;
    }
    bool isMaxLimitOver = ((productModel?.cartCount??0) >= (productModel?.productStockQuantity??0));
    bool isOutOfStock = ((productModel?.productStockQuantity??0)<1);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.whiteColor(),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 2,
              offset: Offset(1, 1), // Shadow position
            ),
          ]
      ),
      width: width,
      height: height,
      margin: const EdgeInsets.only(left: 5,right: 5,bottom: 5),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Opacity(
            opacity: isOutOfStock ? 0.5 : 1,
            child: Column(
              children: [

                // image not fit in width
                SizedBox(
                  height: 176,
                  child: InkWell(
                    onTap: (){
                      if(formHome){
                        Get.toNamed(rsProductDetailPage,arguments: { "product_id" : productModel?.id ?? 0,"variant_id":productModel?.productVerientId ?? 0,"from_home" : true },preventDuplicates: false);
                      }else{
                        Get.offNamed(rsProductDetailPage,arguments: { "product_id" : productModel?.id ?? 0,"variant_id":productModel?.productVerientId ?? 0 },preventDuplicates: false);
                      }
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
                            fit: BoxFit.cover,
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
                                      RatingBar(rating: productModel?.rating??1,starNum: 1,size: 13,),

                                      const SizedBox(width: 2,),
                                      Text("${productModel?.rating}",style: TextStyle(
                                          color: AppColors.whiteColor(),
                                          fontSize: 10,
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
                ),

                const Spacer(),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [

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
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    color: AppColors.redColor(),
                                    decoration: TextDecoration.lineThrough,
                                    letterSpacing: -0.4,
                                  ),
                                ),
                              const SizedBox(width: 5,),
                              Text(PriceConverter.removeDecimalZeroFormatWithFlag(productModel?.price ?? 0),
                                maxLines: 1,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: AppColors.primaryColor(),
                                  letterSpacing: -0.4,
                                ),
                              ),
                              // Text(
                              //   'price',
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

                      const SizedBox(height: 8,),
                      if(!((productModel?.quantity??0)<0))
                        SizedBox(
                          width: width,
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

                const Spacer(),
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

// import 'package:flutter/material.dart';
// import 'package:flutter_remix/flutter_remix.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:indiakinursery/utils/string_extensions.dart';
// import 'package:indiakinursery/view/widget/product/grid_product_view.dart';
//
// import '../../../core/routes.dart';
// import '../../../theme/app_colors.dart';
// import '../../../model/ProductModel.dart';
// import '../../../utils/price_converter.dart';
// import '../../../utils/string_helper.dart';
// import '../common_image.dart';
// import '../common_material_button.dart';
// import '../increase_decrease_buttons.dart';
// import '../rating_bar.dart';
//
// class HorizontalProductView extends StatelessWidget {
//   final ProductModel? productModel;
//   final bool formHome;
//   final double width;
//   final double height;
//   final Function()? onIncrease;
//   final Function()? addToCart;
//   final Function()? onDecrease;
//   const HorizontalProductView({
//     Key? key,
//     this.productModel,
//     this.formHome = false,
//     this.onIncrease,
//     this.onDecrease,
//     this.addToCart,
//     required this.width,
//     required this.height,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     String productImage = StringHelper.fistValueOfCommaSeparated(value: productModel?.allImagesUrl);
//     if (productImage.isEmpty) {
//       productImage = StringHelper.productImage;
//     }
//     return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
//       return Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10.r),
//           color: AppColors.whiteColor(),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 2,
//               offset: const Offset(1, 1), // Shadow position
//             ),
//           ],
//         ),
//         width: width,
//         height: height,
//         margin: const EdgeInsets.only(left: 5,right: 5,bottom: 5),
//         child: Column(
//           children: [
//             InkWell(
//               onTap: () {
//                 if (formHome) {
//                   Get.toNamed(rsProductDetailPage, arguments: {"product_id": productModel?.id ?? 0, "variant_id": productModel?.productVerientId ?? 0}, preventDuplicates: false);
//                 } else {
//                   Get.offNamed(rsProductDetailPage, arguments: {"product_id": productModel?.id ?? 0, "variant_id": productModel?.productVerientId ?? 0}, preventDuplicates: false);
//                 }
//               },
//               child: SizedBox(
//                 height: constraints.maxHeight * 0.6,
//                 child: Stack(
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.only(
//                         topRight: Radius.circular(10.r),
//                         topLeft: Radius.circular(10.r),
//                       ),
//                       child: CommonImage(
//                         imageUrl: productImage,
//                         height: width * 0.8,
//                         width: 1000,
//                         fit: BoxFit.cover,
//                         radius: 0,
//                       ),
//                     ),
//
//                     /// Top-Left of image sticker-banner
//                     if (formHome)
//                       Positioned(
//                         left: 0.r,
//                         top: 0.r,
//                         child: Column(
//                           children: [
//                             if (false) ...[
//                               Container(
//                                 decoration: BoxDecoration(
//                                   color: AppColors.redColor(),
//                                   borderRadius: BorderRadius.all(Radius.circular(3.r)),
//                                 ),
//                                 padding: EdgeInsets.symmetric(horizontal: 5.r, vertical: 2.r),
//                                 child: Text(
//                                   "out of stock",
//                                   style: TextStyle(
//                                     color: AppColors.whiteColor(),
//                                     fontSize: 12.sp,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 ),
//                               ),
//                             ] else ...[
//                               if ((productModel?.discount ?? 0) > 0) ...[
//                                 Container(
//                                   decoration: BoxDecoration(
//                                     color: Colors.red,
//                                     borderRadius: BorderRadius.only(
//                                       bottomRight: Radius.circular(3.r),
//                                       topLeft: Radius.circular(3.r),
//                                     ),
//                                   ),
//                                   padding: EdgeInsets.symmetric(horizontal: 5.r, vertical: 2.r),
//                                   child: Text(
//                                     "${productModel?.discount} % OFF",
//                                     style: TextStyle(
//                                       color: AppColors.whiteColor(),
//                                       fontSize: 12.sp,
//                                       fontWeight: FontWeight.w400,
//                                     ),
//                                   ),
//                                 ),
//                               ] else ...[
//                                 if (StringHelper.isWithinLast10Days(productModel?.createdOn)) ...[
//                                   Container(
//                                     decoration: BoxDecoration(
//                                       color: AppColors.primaryColor(),
//                                       borderRadius: BorderRadius.only(
//                                         bottomRight: Radius.circular(3.r),
//                                         topLeft: Radius.circular(3.r),
//                                       ),
//                                     ),
//                                     padding: EdgeInsets.symmetric(horizontal: 5.r, vertical: 2.r),
//                                     child: Text(
//                                       "new",
//                                       style: TextStyle(
//                                         color: AppColors.whiteColor(),
//                                         fontSize: 12.sp,
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     ),
//                                   ),
//                                 ] else ...[
//                                   Container(
//                                     decoration: BoxDecoration(
//                                       color: Colors.red,
//                                       borderRadius: BorderRadius.only(
//                                         bottomRight: Radius.circular(3.r),
//                                         topLeft: Radius.circular(3.r),
//                                       ),
//                                     ),
//                                     padding: EdgeInsets.symmetric(horizontal: 5.r, vertical: 2.r),
//                                     child: Text(
//                                       "Sale",
//                                       style: TextStyle(
//                                         color: AppColors.whiteColor(),
//                                         fontSize: 12.sp,
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ],
//                             ],
//                           ],
//                         ),
//                       ),
//
//                     /// Bottom-Right of image sticker-banner
//                     if ((productModel?.rating ?? 0.0) > 0)
//                       Positioned(
//                         right: 10.r,
//                         bottom: 10.r,
//                         child: Column(
//                           children: [
//                             Container(
//                               decoration: BoxDecoration(
//                                 color: AppColors.blackColor().withOpacity(0.5),
//                                 borderRadius: BorderRadius.all(Radius.circular(3.r)),
//                               ),
//                               padding: EdgeInsets.symmetric(horizontal: 5.r, vertical: 2.r),
//                               child: Row(
//                                 children: [
//                                   RatingBar(rating: productModel?.rating ?? 1, starNum: 1, size: 13,),
//                                   2.horizontalSpace,
//                                   Text(
//                                     "${productModel?.rating}",
//                                     style: TextStyle(
//                                       color: AppColors.whiteColor(),
//                                       fontSize: 10.sp,
//                                       fontWeight: FontWeight.w400,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               child: Column(
//                 children: [
//                   Text(
//                     (productModel?.verientName ?? "").toCapitalizeFirstLetter(),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       fontWeight: FontWeight.w700,
//                       fontSize: 13.sp,
//                       color: AppColors.text2,
//                       letterSpacing: -0.4,
//                     ),
//                   ),
//                   2.verticalSpace,
//                   Text(
//                     (productModel?.name ?? "").toCapitalizeFirstLetter(),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       fontWeight: FontWeight.w300,
//                       fontSize: 10.sp,
//                       color: AppColors.text2,
//                       letterSpacing: -0.4,
//                     ),
//                   ),
//                   4.verticalSpace,
//                   Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(
//                             PriceConverter.removeDecimalZeroFormatWithFlag(productModel?.mrp ?? 0),
//                             maxLines: 1,
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 10.sp,
//                               color: AppColors.redColor(),
//                               decoration: TextDecoration.lineThrough,
//                               letterSpacing: -0.4,
//                             ),
//                           ),
//                           5.horizontalSpace,
//                           Text(
//                             PriceConverter.removeDecimalZeroFormatWithFlag(productModel?.price ?? 0),
//                             maxLines: 1,
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 13.sp,
//                               color: AppColors.primaryColor(),
//                               letterSpacing: -0.4,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//
//                   if (formHome)...[
//                     4.verticalSpace,
//                     if (!((productModel?.quantity ?? 0) < 0))
//                       SizedBox(
//                         width: width,
//                         height: 35.h,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             if ((productModel?.cartCount ?? 0) < 1)...[
//                               Flexible(
//                                 child: CommonMaterialButton(
//                                   text: "Add",
//                                   iconData: FlutterRemix.shopping_basket_2_fill,
//                                   height: 35.h,
//                                   horizontalPadding: 10,
//                                   borderRadius: 5.r,
//                                   fontColor: AppColors.text2,
//                                   color: AppColors.cartButtonColor,
//                                   fontWeight: FontWeight.w500,
//                                   isLoading: productModel?.isIncrease ?? false,
//                                   onTap: () {
//                                     if (addToCart != null) {
//                                       addToCart!();
//                                     }
//                                   },
//                                 ),
//                               ),
//                             ] else...[
//                               Expanded(
//                                 child: IncreaseDecreaseButtons(
//                                   onDecrease: onDecrease,
//                                   isDecrease: productModel?.isDecrease,
//                                   isIncrease: productModel?.isIncrease,
//                                   onIncrease: onIncrease,
//                                   cartCount: productModel?.cartCount,
//                                 ),
//                               ),
//                             ],
//                           ],
//                         ),
//                       ),
//                   ],
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//   //   return LayoutBuilder(
//   //       builder: (BuildContext context, BoxConstraints constraints) {
//   //     return Container(
//   //       decoration: BoxDecoration(
//   //         borderRadius: BorderRadius.circular(10.r),
//   //         color: AppColors.whiteColor(),
//   //         boxShadow: [
//   //           BoxShadow(
//   //             color: Colors.black12,
//   //             blurRadius: 2,
//   //             offset: const Offset(1, 1), // Shadow position
//   //           ),
//   //         ],
//   //       ),
//   //       width: width,
//   //       height: height,
//   //       // margin: EdgeInsets.only(left: 5,right: 5,bottom: 5),
//   //       child: Column(
//   //         children: [
//   //           InkWell(
//   //             onTap: () {
//   //               if (formHome) {
//   //                 Get.toNamed(rsProductDetailPage, arguments: {"product_id": productModel?.id ?? 0, "variant_id": productModel?.productVerientId ?? 0}, preventDuplicates: false);
//   //               } else {
//   //                 Get.offNamed(rsProductDetailPage, arguments: {"product_id": productModel?.id ?? 0, "variant_id": productModel?.productVerientId ?? 0}, preventDuplicates: false);
//   //               }
//   //             },
//   //             child: SizedBox(
//   //               height: constraints.maxHeight * 0.5,
//   //               child: Stack(
//   //                 children: [
//   //                   ClipRRect(
//   //                     borderRadius: BorderRadius.only(
//   //                       topRight: Radius.circular(10.r),
//   //                       topLeft: Radius.circular(10.r),
//   //                     ),
//   //                     child: CommonImage(
//   //                       imageUrl: productImage,
//   //                       height: constraints.maxHeight * 0.5,
//   //                       width: 1000,
//   //                       fit: BoxFit.cover,
//   //                       radius: 0,
//   //                     ),
//   //                   ),
//   //
//   //                   /// Top-Left of image sticker-banner
//   //                   if (formHome)
//   //                     Positioned(
//   //                       left: 0.r,
//   //                       top: 0.r,
//   //                       child: Column(
//   //                         children: [
//   //                           if (false) ...[
//   //                             Container(
//   //                               decoration: BoxDecoration(
//   //                                 color: AppColors.redColor(),
//   //                                 borderRadius: BorderRadius.all(Radius.circular(3.r)),
//   //                               ),
//   //                               padding: EdgeInsets.symmetric(horizontal: 5.r, vertical: 2.r),
//   //                               child: Text(
//   //                                 "out of stock",
//   //                                 style: TextStyle(
//   //                                   color: AppColors.whiteColor(),
//   //                                   fontSize: 12.sp,
//   //                                   fontWeight: FontWeight.w400,
//   //                                 ),
//   //                               ),
//   //                             ),
//   //                           ] else ...[
//   //                             if ((productModel?.discount ?? 0) > 0) ...[
//   //                               Container(
//   //                                 decoration: BoxDecoration(
//   //                                   color: Colors.red,
//   //                                   borderRadius: BorderRadius.only(
//   //                                     bottomRight: Radius.circular(3.r),
//   //                                     topLeft: Radius.circular(3.r),
//   //                                   ),
//   //                                 ),
//   //                                 padding: EdgeInsets.symmetric(horizontal: 5.r, vertical: 2.r),
//   //                                 child: Text(
//   //                                   "${productModel?.discount} % OFF",
//   //                                   style: TextStyle(
//   //                                     color: AppColors.whiteColor(),
//   //                                     fontSize: 12.sp,
//   //                                     fontWeight: FontWeight.w400,
//   //                                   ),
//   //                                 ),
//   //                               ),
//   //                             ] else ...[
//   //                               if (StringHelper.isWithinLast10Days(productModel?.createdOn)) ...[
//   //                                 Container(
//   //                                   decoration: BoxDecoration(
//   //                                     color: AppColors.primaryColor(),
//   //                                     borderRadius: BorderRadius.only(
//   //                                       bottomRight: Radius.circular(3.r),
//   //                                       topLeft: Radius.circular(3.r),
//   //                                     ),
//   //                                   ),
//   //                                   padding: EdgeInsets.symmetric(horizontal: 5.r, vertical: 2.r),
//   //                                   child: Text(
//   //                                     "new",
//   //                                     style: TextStyle(
//   //                                       color: AppColors.whiteColor(),
//   //                                       fontSize: 12.sp,
//   //                                       fontWeight: FontWeight.w400,
//   //                                     ),
//   //                                   ),
//   //                                 ),
//   //                               ] else ...[
//   //                                 Container(
//   //                                   decoration: BoxDecoration(
//   //                                     color: Colors.red,
//   //                                     borderRadius: BorderRadius.only(
//   //                                       bottomRight: Radius.circular(3.r),
//   //                                       topLeft: Radius.circular(3.r),
//   //                                     ),
//   //                                   ),
//   //                                   padding: EdgeInsets.symmetric(horizontal: 5.r, vertical: 2.r),
//   //                                   child: Text(
//   //                                     "Sale",
//   //                                     style: TextStyle(
//   //                                       color: AppColors.whiteColor(),
//   //                                       fontSize: 12.sp,
//   //                                       fontWeight: FontWeight.w400,
//   //                                     ),
//   //                                   ),
//   //                                 ),
//   //                               ],
//   //                             ],
//   //                           ],
//   //                         ],
//   //                       ),
//   //                     ),
//   //
//   //                   /// Bottom-Right of image sticker-banner
//   //                   if ((productModel?.rating ?? 0.0) > 0)
//   //                     Positioned(
//   //                       right: 10.r,
//   //                       bottom: 10.r,
//   //                       child: Column(
//   //                         children: [
//   //                           Container(
//   //                             decoration: BoxDecoration(
//   //                               color: AppColors.blackColor().withOpacity(0.5),
//   //                               borderRadius: BorderRadius.all(Radius.circular(3.r)),
//   //                             ),
//   //                             padding: EdgeInsets.symmetric(horizontal: 5.r, vertical: 2.r),
//   //                             child: Row(
//   //                               children: [
//   //                                 RatingBar(rating: productModel?.rating ?? 1, starNum: 1, size: 13,),
//   //                                 2.horizontalSpace,
//   //                                 Text(
//   //                                   "${productModel?.rating}",
//   //                                   style: TextStyle(
//   //                                     color: AppColors.whiteColor(),
//   //                                     fontSize: 10.sp,
//   //                                     fontWeight: FontWeight.w400,
//   //                                   ),
//   //                                 ),
//   //                               ],
//   //                             ),
//   //                           ),
//   //                         ],
//   //                       ),
//   //                     ),
//   //                 ],
//   //               ),
//   //             ),
//   //           ),
//   //
//   //           SizedBox(
//   //             height: constraints.maxHeight * 0.5,
//   //             child: Padding(
//   //               padding: const EdgeInsets.symmetric(horizontal: 10),
//   //               child: Column(
//   //                 children: [
//   //                   Text(
//   //                     (productModel?.verientName ?? "").toCapitalizeFirstLetter(),
//   //                     maxLines: 1,
//   //                     overflow: TextOverflow.ellipsis,
//   //                     style: TextStyle(
//   //                       fontWeight: FontWeight.w700,
//   //                       fontSize: 13.sp,
//   //                       color: AppColors.text2,
//   //                       letterSpacing: -0.4,
//   //                     ),
//   //                   ),
//   //                   2.verticalSpace,
//   //                   Text(
//   //                     (productModel?.name ?? "").toCapitalizeFirstLetter(),
//   //                     maxLines: 1,
//   //                     overflow: TextOverflow.ellipsis,
//   //                     style: TextStyle(
//   //                       fontWeight: FontWeight.w300,
//   //                       fontSize: 10.sp,
//   //                       color: AppColors.text2,
//   //                       letterSpacing: -0.4,
//   //                     ),
//   //                   ),
//   //                   4.verticalSpace,
//   //                   Column(
//   //                     mainAxisSize: MainAxisSize.min,
//   //                     children: [
//   //                       Row(
//   //                         mainAxisSize: MainAxisSize.min,
//   //                         children: [
//   //                           Text(
//   //                             PriceConverter.removeDecimalZeroFormatWithFlag(productModel?.mrp ?? 0),
//   //                             maxLines: 1,
//   //                             style: TextStyle(
//   //                               fontWeight: FontWeight.bold,
//   //                               fontSize: 10.sp,
//   //                               color: AppColors.redColor(),
//   //                               decoration: TextDecoration.lineThrough,
//   //                               letterSpacing: -0.4,
//   //                             ),
//   //                           ),
//   //                           5.horizontalSpace,
//   //                           Text(
//   //                             PriceConverter.removeDecimalZeroFormatWithFlag(productModel?.price ?? 0),
//   //                             maxLines: 1,
//   //                             style: TextStyle(
//   //                               fontWeight: FontWeight.bold,
//   //                               fontSize: 13.sp,
//   //                               color: AppColors.primaryColor(),
//   //                               letterSpacing: -0.4,
//   //                             ),
//   //                           ),
//   //                         ],
//   //                       ),
//   //                     ],
//   //                   ),
//   //
//   //                   if (formHome)...[
//   //                     4.verticalSpace,
//   //                     if (!((productModel?.quantity ?? 0) < 0))
//   //                       SizedBox(
//   //                         width: width,
//   //                         height: 35.h,
//   //                         child: Row(
//   //                           mainAxisAlignment: MainAxisAlignment.center,
//   //                           children: [
//   //                             if ((productModel?.cartCount ?? 0) < 1)...[
//   //                               Flexible(
//   //                                 child: CommonMaterialButton(
//   //                                   text: "Add",
//   //                                   iconData: FlutterRemix.shopping_basket_2_fill,
//   //                                   height: 35.h,
//   //                                   horizontalPadding: 10,
//   //                                   borderRadius: 5.r,
//   //                                   fontColor: AppColors.text2,
//   //                                   color: AppColors.cartButtonColor,
//   //                                   fontWeight: FontWeight.w500,
//   //                                   isLoading: productModel?.isIncrease ?? false,
//   //                                   onTap: () {
//   //                                     if (addToCart != null) {
//   //                                       addToCart!();
//   //                                     }
//   //                                   },
//   //                                 ),
//   //                               ),
//   //                             ] else...[
//   //                               Expanded(
//   //                                 child: IncreaseDecreaseButtons(
//   //                                   onDecrease: onDecrease,
//   //                                   isDecrease: productModel?.isDecrease,
//   //                                   isIncrease: productModel?.isIncrease,
//   //                                   onIncrease: onIncrease,
//   //                                   cartCount: productModel?.cartCount,
//   //                                 ),
//   //                               ),
//   //                             ],
//   //                           ],
//   //                         ),
//   //                       ),
//   //                   ],
//   //                 ],
//   //               ),
//   //             ),
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }
//   }
// }
//
// // import 'package:flutter/material.dart';
// // import 'package:flutter_remix/flutter_remix.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:get/get.dart';
// // import 'package:indiakinursery/utils/string_extensions.dart';
// // import 'package:indiakinursery/view/widget/product/grid_product_view.dart';
// //
// // import '../../../core/routes.dart';
// // import '../../../theme/app_colors.dart';
// // import '../../../model/ProductModel.dart';
// // import '../../../utils/price_converter.dart';
// // import '../../../utils/string_helper.dart';
// // import '../common_image.dart';
// // import '../common_material_button.dart';
// // import '../increase_decrease_buttons.dart';
// // import '../rating_bar.dart';
// //
// // class HorizontalProductView extends StatelessWidget {
// //   final ProductModel? productModel;
// //   final bool formHome;
// //   final double width;
// //   final double height;
// //   final Function()? onIncrease;
// //   final Function()? addToCart;
// //   final Function()? onDecrease;
// //   const HorizontalProductView({Key? key,this.productModel,
// //     this.formHome = false,
// //     this.onIncrease,
// //     this.onDecrease,
// //     this.addToCart,
// //     required this.width,
// //     required this.height,
// //   }) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     String productImage = StringHelper.fistValueOfCommaSeparated(value: productModel?.allImagesUrl);
// //     if(productImage.isEmpty){
// //       productImage = StringHelper.productImage;
// //     }
// //     return Container(
// //       decoration: BoxDecoration(
// //           borderRadius: BorderRadius.circular(10.r),
// //           color: AppColors.whiteColor(),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black12,
// //             blurRadius: 2,
// //             offset: const Offset(1, 1), // Shadow position
// //           ),
// //         ]
// //       ),
// //       width: width,
// //       height: height,
// //      // margin: EdgeInsets.only(left: 5,right: 5,bottom: 5),
// //       child: Column(
// //         children: [
// //
// //           // image not fit in width
// //           InkWell(
// //             onTap: (){
// //               if(formHome){
// //                 Get.toNamed(rsProductDetailPage,arguments: { "product_id" : productModel?.id ?? 0,"variant_id":productModel?.productVerientId ?? 0 },preventDuplicates: false);
// //               }else{
// //                 Get.offNamed(rsProductDetailPage,arguments: { "product_id" : productModel?.id ?? 0,"variant_id":productModel?.productVerientId ?? 0 },preventDuplicates: false);
// //               }
// //             },
// //             child: SizedBox(
// //               height: height*0.5,
// //               child: Stack(
// //                 children: [
// //                   ClipRRect(
// //                     borderRadius: BorderRadius.only(
// //                       topRight: Radius.circular(10.r),
// //                       topLeft: Radius.circular(10.r),
// //                     ),
// //                     child: CommonImage(
// //                       imageUrl: productImage,
// //                       height: height*0.5,
// //                       width: 1000,
// //                       fit: BoxFit.cover,
// //                       radius: 0,
// //                     ),
// //                   ),
// //
// //                   /// Top-Left of image sticker-banner
// //                   if(formHome)
// //                   Positioned(
// //                     left: 0.r,
// //                     top: 0.r,
// //                     child: Column(
// //                       children: [
// //                         if(false)...[
// //                           Container(
// //                             decoration: BoxDecoration(
// //                                 color: AppColors.redColor(),
// //                                 borderRadius: BorderRadius.all(Radius.circular(3.r))
// //                             ),
// //                             padding: EdgeInsets.symmetric(horizontal: 5.r,vertical: 2.r),
// //                             child: Text("out of stock",style: TextStyle(
// //                                 color: AppColors.whiteColor(),
// //                                 fontSize: 12.sp,
// //                                 fontWeight: FontWeight.w400
// //                             ),),
// //                           ),
// //                         ]else...[
// //                           if((productModel?.discount??0) > 0)...[
// //                             Container(
// //                               decoration: BoxDecoration(
// //                                   color: Colors.red,
// //                                   borderRadius: BorderRadius.only(
// //                                     bottomRight: Radius.circular(3.r),
// //                                     topLeft: Radius.circular(3.r)
// //                                   )
// //                               ),
// //                               padding: EdgeInsets.symmetric(horizontal: 5.r,vertical: 2.r),
// //                               child: Text("${productModel?.discount} % OFF",style: TextStyle(
// //                                   color: AppColors.whiteColor(),
// //                                   fontSize: 12.sp,
// //                                   fontWeight: FontWeight.w400
// //                               ),),
// //                             ),
// //                           ]else...[
// //                             if(StringHelper.isWithinLast10Days(productModel?.createdOn))...[
// //                               Container(
// //                                 decoration: BoxDecoration(
// //                                     color: AppColors.primaryColor(),
// //                                     borderRadius: BorderRadius.only(
// //                                         bottomRight: Radius.circular(3.r),
// //                                         topLeft: Radius.circular(3.r)
// //                                     )
// //                                 ),
// //                                 padding: EdgeInsets.symmetric(horizontal: 5.r,vertical: 2.r),
// //                                 child: Text("new",style: TextStyle(
// //                                     color: AppColors.whiteColor(),
// //                                     fontSize: 12.sp,
// //                                     fontWeight: FontWeight.w400
// //                                 ),),
// //                               ),
// //                             ]else...[
// //                               Container(
// //                                 decoration: BoxDecoration(
// //                                     color: Colors.red,
// //                                     borderRadius: BorderRadius.only(
// //                                         bottomRight: Radius.circular(3.r),
// //                                         topLeft: Radius.circular(3.r)
// //                                     )
// //                                 ),
// //                                 padding: EdgeInsets.symmetric(horizontal: 5.r,vertical: 2.r),
// //                                 child: Text("Sale",style: TextStyle(
// //                                     color: AppColors.whiteColor(),
// //                                     fontSize: 12.sp,
// //                                     fontWeight: FontWeight.w400
// //                                 ),),
// //                               ),
// //                             ]
// //                           ],
// //                         ],
// //                       ],
// //                     ),
// //                   ),
// //
// //
// //                   /// Bottom-Right of image sticker-banner
// //                   if((productModel?.rating??0.0) > 0)
// //                     Positioned(
// //                       right: 10.r,
// //                       bottom: 10.r,
// //                       child: Column(
// //                         children: [
// //                           Container(
// //                             decoration: BoxDecoration(
// //                                 color: AppColors.blackColor().withOpacity(0.5),
// //                                 borderRadius: BorderRadius.all(Radius.circular(3.r))
// //                             ),
// //                             padding: EdgeInsets.symmetric(horizontal: 5.r,vertical: 2.r),
// //                             child: Row(
// //                               children: [
// //                                 RatingBar(rating: productModel?.rating??1,starNum: 1,size: 13,),
// //                                 2.horizontalSpace,
// //                                 Text("${productModel?.rating}",style: TextStyle(
// //                                     color: AppColors.whiteColor(),
// //                                     fontSize: 10.sp,
// //                                     fontWeight: FontWeight.w400
// //                                 ),),
// //                               ],
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //
// //          // 6.verticalSpace,
// //
// //           SizedBox(
// //             height: height*0.5,
// //             child: Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: 10),
// //               child: Column(
// //                 children: [
// //
// //                   Text((productModel?.verientName ?? "").toCapitalizeFirstLetter(),
// //                     maxLines: 1,
// //                     overflow: TextOverflow.ellipsis,
// //                     style: TextStyle(
// //                       fontWeight: FontWeight.w700,
// //                       fontSize: 13.sp,
// //                       color: AppColors.text2,
// //                       letterSpacing: -0.4,
// //                     ),
// //                   ),
// //                   2.verticalSpace,
// //                   Text((productModel?.name ?? "").toCapitalizeFirstLetter(),
// //                     maxLines: 1,
// //                     overflow: TextOverflow.ellipsis,
// //                     style: TextStyle(
// //                       fontWeight: FontWeight.w300,
// //                       fontSize: 10.sp,
// //                       color: AppColors.text2,
// //                       letterSpacing: -0.4,
// //                     ),
// //                   ),
// //                   4.verticalSpace,
// //                   Column(
// //                     mainAxisSize: MainAxisSize.min,
// //                     children: [
// //                       Row(
// //                         mainAxisSize: MainAxisSize.min,
// //                         children: [
// //                           Text(PriceConverter.removeDecimalZeroFormatWithFlag(productModel?.mrp ?? 0),
// //                             maxLines: 1,
// //                             style: TextStyle(
// //                               fontWeight: FontWeight.bold,
// //                               fontSize: 10.sp,
// //                               color: AppColors.redColor(),
// //                               decoration: TextDecoration.lineThrough,
// //                               letterSpacing: -0.4,
// //                             ),
// //                           ),
// //                           5.horizontalSpace,
// //                           Text(PriceConverter.removeDecimalZeroFormatWithFlag(productModel?.price ?? 0),
// //                             maxLines: 1,
// //                             style: TextStyle(
// //                               fontWeight: FontWeight.bold,
// //                               fontSize: 13.sp,
// //                               color: AppColors.primaryColor(),
// //                               letterSpacing: -0.4,
// //                             ),
// //                           ),
// //                           // Text(
// //                           //   'price',
// //                           //   style: TextStyle(
// //                           //     fontWeight: FontWeight.w300,
// //                           //     fontSize: 12.sp,
// //                           //     color: AppColors.primaryColor(),
// //                           //     letterSpacing: -0.4,
// //                           //   ),
// //                           // ),
// //                         ],
// //                       ),
// //                     ],
// //                   ),
// //
// //                   if(formHome)...[
// //                     4.verticalSpace,
// //                     if(!((productModel?.quantity??0)<0))
// //                       SizedBox(
// //                         width: width,
// //                         height: 35.h,
// //                         child: Row(
// //                           mainAxisAlignment: MainAxisAlignment.center,
// //                           children: [
// //                             if((productModel?.cartCount ?? 0) < 1)...[
// //                               Flexible(
// //                                 child: CommonMaterialButton(
// //                                   text: "Add",
// //                                   iconData: FlutterRemix.shopping_basket_2_fill,
// //                                   height: 35.h,
// //                                   horizontalPadding: 10,
// //                                   borderRadius: 5.r,
// //                                   fontColor: AppColors.text2,
// //                                   color: AppColors.cartButtonColor,
// //                                   //color: Colors.grey.withOpacity(0.3),
// //                                   fontWeight: FontWeight.w500,
// //                                   isLoading: productModel?.isIncrease ?? false,
// //                                   onTap: () {
// //                                     if(addToCart != null){
// //                                       addToCart!();
// //                                     }
// //                                   },
// //                                 ),
// //                               ),
// //                             ]else...[
// //                               Expanded(
// //                                 child: IncreaseDecreaseButtons(
// //                                   onDecrease: onDecrease,
// //                                   isDecrease: productModel?.isDecrease,
// //                                   isIncrease: productModel?.isIncrease,
// //                                   onIncrease: onIncrease,
// //                                   cartCount: productModel?.cartCount,
// //                                 ),
// //                               ),
// //                             ],
// //                           ],
// //                         ),
// //                       ),
// //                   ]
// //                 ],
// //               ),
// //             ),
// //           )
// //         ],
// //       ),
// //     );
// //   }
// // }
