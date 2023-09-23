import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:indiakinursery/controller/home_controller.dart';
import 'package:indiakinursery/utils/assets.dart';
import 'package:indiakinursery/utils/string_extensions.dart';
import 'package:indiakinursery/view/product_detail/shimmer.dart';
import 'package:indiakinursery/view/widget/product/grid_product_view.dart';

import '../../controller/cart_controller.dart';
import '../../theme/app_colors.dart';
import '../../utils/price_converter.dart';
import '../../utils/string_helper.dart';
import '../home/view.dart';
import '../login/view.dart';
import '../widget/api_error/not_found.dart';
import '../widget/common_image.dart';
import '../widget/common_material_button.dart';
import '../widget/increase_decrease_buttons.dart';
import '../widget/product/horizontal_product_view.dart';
import '../widget/rating_bar.dart';
import '../widget/toast.dart';
import 'logic.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
   bool isSmall = !isLargeScreen(size);
   double horizontalPadding = getScreenPadding(size);
   double variationWidth = isSmall ? ((Get.width-(horizontalPadding*2))/4) : 150;//Width
   double variationHeight = variationWidth;
   double heightOfRelatedProduct = 300;
   double widthOfRelatedProduct = !isSmall ? 200 : ((Get.width / 2) - (horizontalPadding));
    return Container(
      color: AppColors.whiteColor(),
      child: GetBuilder<ProductDetailLogic>(
        assignId: true,
        builder: (logic) {
          bool isOutOfStock = (logic.productModel?.productStockQuantity??0)<1;
          return Scaffold(
            backgroundColor: Colors.blueGrey.withOpacity(0.1),
            bottomNavigationBar: Get.find<HomeLogic>().getBottomBar(),
            appBar: AppBar(title: Text((logic.productModel?.verientName??"").toCapitalizeFirstLetter())),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  10.verticalSpace,

                  if(logic.apiProcess)...[
                    const ProductDetailShimmer()
                  ]else...[

                    if(logic.productModel != null)...[
                      if(logic.productImage.isNotEmpty)
                        Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            CarouselSlider.builder(
                              itemCount: logic.productImage.length,
                              options: CarouselOptions(
                                  autoPlay: logic.productImage.length > 1,
                                  viewportFraction: 1,
                                  aspectRatio: size.width > 600 ? (size.width > 900 ? 3.0 : 1.8) : 1.2,
                                  initialPage: 0,
                                  onPageChanged: (index, reason) {
                                    logic.setIndex(index);
                                  }
                              ),
                              itemBuilder: (context, index, realIdx) {
                                return Stack(
                                  children: [

                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                                      width: size.width,
                                      child: Stack(
                                        children: [
                                          CommonImage(
                                            imageUrl: logic.productImage[index],
                                            width: size.width,
                                            radius: 10,
                                            assetPlaceholder: appProductDemo,
                                            fit: BoxFit.fitHeight,
                                          ),

                                          /// Top-Left of image sticker-banner
                                          if(isOutOfStock)...[
                                            Positioned(
                                              left: 0,
                                              top: 0,
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius: BorderRadius.only(
                                                        bottomRight: Radius.circular(3),
                                                        topLeft: Radius.circular(3)
                                                    )
                                                ),
                                                padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                                                child: Text("Out Of Stock".tr,style: TextStyle(
                                                    color: AppColors.whiteColor(),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400
                                                ),),
                                              ),
                                            ),
                                          ]else...[
                                            if((logic.productModel?.discount??0) > 0)...[
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius: BorderRadius.only(
                                                          bottomRight: Radius.circular(3),
                                                          topLeft: Radius.circular(3)
                                                      )
                                                  ),
                                                  padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                                                  child: Text("${PriceConverter.getSingleDigit(logic.productModel?.discount??0)} % OFF",style: TextStyle(
                                                      color: AppColors.whiteColor(),
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w400
                                                  ),),
                                                ),
                                              ),
                                            ],
                                          ],

                                          /// Top-Right of image sticker-banner
                                          Positioned(
                                            right: 0,
                                            top: 0,
                                            child: Column(
                                              children: [
                                                if(logic.productModel?.isFetured?.isNotEmpty??false)...[
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
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),

                            if(logic.productImage.length > 1)
                              Positioned(
                                bottom: -30,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      for(int i = 0; i < logic.productImage.length;i++)...[
                                        Container(
                                          width: 8.0,
                                          height: 8.0,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 2.0),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: logic.current == i
                                                ? const Color.fromRGBO(0, 0, 0, 0.9)
                                                : const Color.fromRGBO(0, 0, 0, 0.4),
                                          ),
                                        ),
                                      ],
                                      // logic.productImage.map((url) {
                                      //   int index = logic.productImage.indexOf(url);
                                      //   return Container(
                                      //     width: 8.0,
                                      //     height: 8.0,
                                      //     margin: const EdgeInsets.symmetric(
                                      //         vertical: 10.0, horizontal: 2.0),
                                      //     decoration: BoxDecoration(
                                      //       shape: BoxShape.circle,
                                      //       color: logic.current == index
                                      //           ? const Color.fromRGBO(0, 0, 0, 0.9)
                                      //           : const Color.fromRGBO(0, 0, 0, 0.4),
                                      //     ),
                                      //   );
                                      // }).toList(),
                                    ]
                                  // children: logic.productImage.map((url) {
                                  //   int index = logic.productImage.indexOf(url);
                                  //   return Container(
                                  //     width: 8.0,
                                  //     height: 8.0,
                                  //     margin: const EdgeInsets.symmetric(
                                  //         vertical: 10.0, horizontal: 2.0),
                                  //     decoration: BoxDecoration(
                                  //       shape: BoxShape.circle,
                                  //       color: logic.current == index
                                  //           ? const Color.fromRGBO(0, 0, 0, 0.9)
                                  //           : const Color.fromRGBO(0, 0, 0, 0.4),
                                  //     ),
                                  //   );
                                  // }).toList(),
                                ),)
                          ],),

                      50.verticalSpace,

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: horizontalPadding,vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text((logic.productModel?.verientName ?? "").toCapitalizeFirstLetter(),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: isSmall ? 20 : 25,
                                color: AppColors.textColor(),
                                letterSpacing: -0.4,
                              ),
                            ),
                            4.verticalSpace,
                            Row(
                              children: [
                                Text((logic.productModel?.name ?? "").toCapitalizeFirstLetter(),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: isSmall ? 17 : 20,
                                    color: AppColors.textColor(),
                                    letterSpacing: -0.4,
                                  ),
                                ),
                              ],
                            ),
                            12.verticalSpace,
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Text("STOCK QUANTITY:",
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: isSmall ? 14 : 17,
                                        color: AppColors.textColor(),
                                        letterSpacing: -0.4,
                                      ),
                                    ),
                                    5.horizontalSpace,
                                    Text("${logic.productModel?.productStockQuantity ?? ""}",
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: isSmall ? 14 : 17,
                                        color: AppColors.textColor(),
                                        letterSpacing: -0.4,
                                      ),
                                    ),
                                  ],
                                ),
                                10.horizontalSpace,
                                Flexible(
                                  child: Row(
                                    children: [
                                      Text("CATEGORY:",
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: isSmall ? 14 : 17,
                                          color: AppColors.textColor(),
                                          letterSpacing: -0.4,
                                        )  ,
                                      ),
                                      5.horizontalSpace,
                                      if(logic.productModel?.categoryName?.isNotEmpty??false)
                                      Text(StringHelper.fistValueOfCommaSeparated(value: logic.productModel?.categoryName ?? ""),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: isSmall ? 14 : 17,
                                          color: AppColors.textColor(),
                                          letterSpacing: -0.4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            10.verticalSpace,
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [


                               if((logic.productModel?.discount??0) > 0)
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Text("MRP:${PriceConverter.removeDecimalZeroFormatWithFlag(logic.productModel?.mrp ?? 0)}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: isSmall ? 15 : 18,
                                      color: AppColors.redColor(),
                                      decoration: TextDecoration.lineThrough,
                                      letterSpacing: -0.4,
                                    ),
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("${PriceConverter.removeDecimalZeroFormatWithFlag(logic.productModel?.price ?? 0)}/-",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: isSmall ? 22 : 30,
                                        color: AppColors.primaryColor(),
                                        letterSpacing: -0.4,
                                      ),
                                    ),
                                    // if((logic.productModel?.quantity??1)>1)
                                    //   Text(
                                    //     '  (${logic.productModel?.quantity} ${logic.productModel?.unit})',
                                    //     style: TextStyle(
                                    //       fontWeight: FontWeight.w300,
                                    //       fontSize: 12.sp,
                                    //       color: AppColors.primaryColor(),
                                    //       letterSpacing: -0.4,
                                    //     ),
                                    //   ),
                                  ],
                                ),


                              ],
                            ),
                            Text("(MRP Inclusive of all taxes)",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: isSmall ? 12 : 14,
                                color: AppColors.textColor(),
                                letterSpacing: -0.4,
                              ),
                            ),

                            10.verticalSpace,
                            if(!isOutOfStock)...[
                              Row(
                                children: [
                                  Expanded(
                                      flex: 5,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          if((logic.productModel?.cartCount ?? 0) < 1)...[
                                            Flexible(
                                              child: CommonMaterialButton(
                                                text: "AddToCart".tr,
                                                iconData: FlutterRemix.shopping_basket_2_fill,
                                                height: isSmall ? 35 : 40,
                                                horizontalPadding: 10,
                                                borderRadius: 5,
                                                fontColor: AppColors.whiteColor(),
                                                color: AppColors.cartButtonColor,
                                                fontWeight: FontWeight.w500,
                                                isLoading: logic.productModel?.isIncrease ?? false,
                                                onTap: () {
                                                  if((logic.productModel?.productStockQuantity??0) < 1){
                                                    Toast.show(toastMessage: "Out of Stock".tr,isError: true);
                                                    return;
                                                  }
                                                  logic.productModel?.isIncrease = true;
                                                  logic.update();
                                                  Get.find<CartController>().addToCart(
                                                      productId: logic.productModel?.id ?? 0,
                                                      variantId: logic.productModel?.productVerientId ?? 0,
                                                      quantity: (logic.productModel?.cartCount ??
                                                          0) + 1,fromProductDetail: true).then((value) =>
                                                  {
                                                    logic.productModel?.isIncrease = false,
                                                    logic.productModel?.cartCount =
                                                        (logic.productModel?.cartCount ?? 0) + 1,
                                                    logic.update(),
                                                  }).catchError((e) {
                                                    logic.productModel?.isIncrease = false;
                                                    logic.update();
                                                  });
                                                },
                                              ),
                                            ),
                                          ]else...[
                                            IncreaseDecreaseButtons(
                                              buttonSize: isSmall ? 30 : 50,
                                              onDecrease: (){
                                                if ((logic.productModel?.cartCount ?? 0) < 1){return;}
                                                logic.productModel?.isDecrease = true;
                                                logic.update();
                                                Get.find<CartController>().updateQuantity(
                                                    productId: logic.productModel?.id ?? 0,
                                                    variantId: logic.productModel?.productVerientId ?? 0,
                                                    quantity: (logic.productModel?.cartCount ??
                                                        0) - 1,fromProductDetail: true).then((value) =>
                                                {
                                                  logic.productModel?.isDecrease = false,
                                                  logic.productModel?.cartCount =
                                                      (logic.productModel?.cartCount ?? 0) - 1,
                                                  logic.update(),
                                                }).catchError((e) {
                                                  logic.productModel?.isDecrease = false;
                                                  logic.update();
                                                });
                                              },
                                              onIncrease:  (){
                                                if((logic.productModel?.productStockQuantity??0) < (logic.productModel
                                                    ?.cartCount ??
                                                    0) + 1){
                                                  Toast.show(toastMessage: "You have reached the maximum".tr,isError: true);
                                                  return;
                                                }
                                                logic.productModel?.isIncrease = true;
                                                logic.update();
                                                Get.find<CartController>().updateQuantity(
                                                    productId: logic.productModel?.id ?? 0,
                                                    variantId: logic.productModel?.productVerientId ?? 0,
                                                    quantity: (logic.productModel?.cartCount ??
                                                        0) + 1,fromProductDetail: true).then((value) =>
                                                {
                                                  logic.productModel?.isIncrease = false,
                                                  logic.productModel?.cartCount =
                                                      (logic.productModel?.cartCount ?? 0) + 1,
                                                  logic.update(),
                                                }).catchError((e) {
                                                  logic.productModel?.isIncrease = false;
                                                  logic.update();
                                                });
                                              },
                                              isDecrease: logic.productModel?.isDecrease,
                                              isIncrease: logic.productModel?.isIncrease,
                                              cartCount: logic.productModel?.cartCount,
                                            ),
                                          ],
                                        ],
                                      )),

                                  const SizedBox(width: 20,),
                                  Expanded(
                                    flex: 5,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        if((logic.productModel?.rating??0)>0)
                                          RatingBar(rating: logic.productModel?.rating??0,ratingCount: PriceConverter.getSingleDigit(logic.productModel?.ratingsCount??0))
                                      ],
                                    )
                                  ),
                                ],
                              ),
                            ]else...[
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.redColor(),
                                        borderRadius: BorderRadius.all(Radius.circular(3.r))
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                                    child: Text("out of stock",style: TextStyle(
                                        color: AppColors.whiteColor(),
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400
                                    ),),
                                  ),
                                  Expanded(
                                      flex: 5,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          if((logic.productModel?.rating??0)>0)
                                            RatingBar(rating: logic.productModel?.rating??0,ratingCount: PriceConverter.getSingleDigit(logic.productModel?.ratingsCount??0))
                                        ],
                                      )
                                  ),
                                ],
                              ),
                            ],

                            20.verticalSpace,
                            if(logic.productVariation.isNotEmpty)...[
                              Text("Variation:",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: isSmall ? 17 : 22,
                                  color: AppColors.textColor(),
                                  letterSpacing: -0.4,
                                ),
                              ),
                              10.verticalSpace,
                              Wrap(
                                children: [
                                  for(int i = 0;i<logic.productVariation.length;i++)...[
                                    InkWell(
                                      onTap: (){
                                        logic.changeVariation(logic.productVariation[i]);
                                      },
                                      child: SizedBox(
                                        width: variationWidth,
                                        height: variationHeight,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                                            border: Border.all(width: 0.5,color: AppColors.grayColor().withOpacity(0.2)),
                                            color: logic.productModel?.productVerientId == logic.productVariation[i].productVerientId ?
                                            AppColors.primary : Colors.grey.shade300,
                                          ),
                                          padding: const EdgeInsets.only(left: 4,right: 4,top: 4,bottom: 4),
                                          margin: const EdgeInsets.only(right: 5,left: 5,bottom: 10),
                                          child: Stack(
                                            children: [
                                              CommonImage(
                                                height: variationHeight,
                                                width: variationWidth,
                                                radius: 0,
                                                assetPlaceholder: appProductDemo,
                                                imageUrl: StringHelper.fistValueOfCommaSeparated(value: logic.productVariation[i].coverImage ?? logic.productVariation[i].allImagesUrl ?? StringHelper.defaultProductImage),
                                              ),
                                              Positioned(
                                                bottom: -1,
                                                child: Container(
                                                  height: 30,
                                                  width: variationWidth,
                                                  color: logic.productModel?.productVerientId == logic.productVariation[i].productVerientId ?
                                                  AppColors.primary : Colors.grey.shade300,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      const SizedBox(height: 2,),
                                                      Row(
                                                        children: [
                                                          Text((("\u{20B9} ${logic.productVariation[i].price??"0"}")),
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                                fontFamily: "Inter",
                                                                color:
                                                                logic.productModel?.productVerientId == logic.productVariation[i].productVerientId ?
                                                                AppColors.whiteColor() : Colors.black87,
                                                                fontSize: 10
                                                            ),),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Flexible(
                                                            child: Text(((logic.productVariation[i].verientName??"").toCapitalizeFirstLetter()),
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                  fontFamily: "Inter",
                                                                  color:
                                                                  logic.productModel?.productVerientId == logic.productVariation[i].productVerientId ?
                                                                  AppColors.whiteColor() : Colors.black87,
                                                                  fontSize: 12
                                                              ),),
                                                          ),
                                                        ],
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ]
                                ],
                              ),
                            ],

                            if(logic.productModel?.verientDescription?.isNotEmpty??false)...[
                              20.verticalSpace,
                              Text("Description:",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: isSmall ? 17 : 20,
                                  color: AppColors.textColor(),
                                  letterSpacing: -0.4,
                                ),
                              ),
                              10.verticalSpace,

                              Text((logic.productModel?.verientDescription ?? "").toCapitalizeFirstLetter(),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: isSmall ? 17 : 20,
                                  color: AppColors.textColor(),
                                  letterSpacing: -0.4,
                                ),
                              ),
                            ],

                            if(logic.productModel?.careAndInstructions?.isNotEmpty??false)...[
                              20.verticalSpace,
                              Text("Care And Instructions:",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: isSmall ? 17 : 20,
                                  color: AppColors.textColor(),
                                  letterSpacing: -0.4,
                                ),
                              ),
                              10.verticalSpace,

                              Text((logic.productModel?.careAndInstructions ?? "").toCapitalizeFirstLetter(),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: isSmall ? 17 : 20,
                                  color: AppColors.textColor(),
                                  letterSpacing: -0.4,
                                ),
                              ),
                            ],

                            if(logic.productModel?.benefits?.isNotEmpty??false)...[
                              20.verticalSpace,
                              Text("Benefits:",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: isSmall ? 17 : 20,
                                  color: AppColors.textColor(),
                                  letterSpacing: -0.4,
                                ),
                              ),
                              10.verticalSpace,

                              Text((logic.productModel?.benefits ?? "").toCapitalizeFirstLetter(),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: isSmall ? 17 : 20,
                                  color: AppColors.textColor(),
                                  letterSpacing: -0.4,
                                ),
                              ),
                            ],

                          ],
                        ),
                      ),

                      if(logic.productReview.isNotEmpty)...[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: horizontalPadding,vertical: 15),
                          child: Text("Review and rating".tr,style: TextStyle(
                              fontWeight: FontWeight.w500,
                            fontSize: isSmall ? 17 : 22,
                          ),),
                        ),

                        for(int index = 0;index<logic.productReview.length;index++)...[
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: horizontalPadding,vertical: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor(),
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                boxShadow: boxShadow(),
                              ),
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [

                                      Container(
                                        width: 54.r,
                                        height: 54.r,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1.r,
                                            color: AppColors.blackColor().withOpacity(0.1),
                                          ),
                                          borderRadius: BorderRadius.circular(64.r),
                                        ),
                                        child: CommonImage(
                                          imageUrl: logic.productReview[index].userName ??"",
                                          assetPlaceholder: "assets/images/default_user.jpg",
                                          width: 50,
                                          height: 50,
                                          radius: 25,
                                        ),
                                      ),

                                      15.horizontalSpace,

                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(logic.productReview[index].userName??"",
                                            style: TextStyle(
                                                color: AppColors.blackColor().withOpacity(0.8),
                                                fontWeight: FontWeight.bold
                                            ),),
                                          5.verticalSpace,
                                          Text((logic.productReview[index].createdOn??"").toDateDMMMY()),
                                        ],
                                      ),
                                    ],
                                  ),

                                  15.verticalSpace,
                                  RatingBar(rating: logic.productReview[index].reviewRating??0.5,size: 24,),

                                  if(logic.productReview[index].comment?.isNotEmpty??false)...[
                                    15.verticalSpace,
                                    Text((logic.productReview[index].comment??"").toCapitalizeFirstLetter()),
                                  ],
                                ],
                              ),
                            ),
                          )
                        ],
                      ],

                      if(logic.relatedProduct.isNotEmpty)...[
                        10.verticalSpace,

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                          child: Text("Related Product".tr,style: TextStyle(
                              fontWeight: FontWeight.w500,
                            fontSize: isSmall ? 17 : 22,
                          ),),
                        ),

                        10.verticalSpace,

                        SizedBox(
                          height: heightOfRelatedProduct,
                          child: ListView.builder(
                            itemCount: logic.relatedProduct.length,
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                            itemBuilder: (context, index) {
                              return SizedBox(
                                  width: widthOfRelatedProduct,
                                  child: HorizontalProductView(
                                    width: widthOfRelatedProduct,
                                    height: heightOfRelatedProduct,
                                    addToCart: (){
                                      if((logic.relatedProduct[index].productStockQuantity??0) < 1){
                                        Toast.show(toastMessage: "Out of Stock".tr,isError: true);
                                        return;
                                      }
                                      logic.relatedProduct[index].isIncrease = true;
                                      logic.update();
                                      Get.find<CartController>().addToCart(
                                          productId: logic.relatedProduct[index].id ?? 0,
                                          variantId: logic.relatedProduct[index].productVerientId ?? 0,
                                          quantity: (logic.relatedProduct[index].cartCount ??
                                              0) + 1,fromProductDetail: true).then((value) =>
                                      {
                                        logic.relatedProduct[index].isIncrease = false,
                                        logic.relatedProduct[index].cartCount =
                                            (logic.relatedProduct[index].cartCount ?? 0) + 1,
                                        logic.update(),
                                      }).catchError((e) {
                                        logic.relatedProduct[index].isIncrease = false;
                                        logic.update();
                                      });
                                    },
                                    onIncrease:  (){
                                      if((logic.relatedProduct[index].productStockQuantity??0) < (logic.relatedProduct[index].cartCount ??
                                          0) + 1){
                                        Toast.show(toastMessage: "You have reached the maximum".tr,isError: true);
                                        return;
                                      }
                                      logic.relatedProduct[index].isIncrease = true;
                                      logic.update();
                                      Get.find<CartController>().updateQuantity(
                                          productId: logic.relatedProduct[index].id ?? 0,
                                          variantId: logic.relatedProduct[index].productVerientId ?? 0,
                                          quantity: (logic.relatedProduct[index].cartCount ??
                                              0) + 1,fromProductDetail: true).then((value) =>
                                      {
                                        logic.relatedProduct[index].isIncrease = false,
                                        logic.relatedProduct[index].cartCount =
                                            (logic.relatedProduct[index].cartCount ?? 0) + 1,
                                        logic.update(),
                                      }).catchError((e) {
                                        logic.relatedProduct[index].isIncrease = false;
                                        logic.update();
                                      });
                                    },
                                    onDecrease: (){
                                      if ((logic.relatedProduct[index].cartCount ?? 0) < 1){return;}
                                      logic.relatedProduct[index].isDecrease = true;
                                      logic.update();
                                      Get.find<CartController>().updateQuantity(
                                          productId: logic.relatedProduct[index].id ?? 0,
                                          variantId: logic.relatedProduct[index].productVerientId ?? 0,
                                          quantity: (logic.relatedProduct[index].cartCount ??
                                              0) - 1,fromProductDetail: true).then((value) =>
                                      {
                                        logic.relatedProduct[index].isDecrease = false,
                                        logic.relatedProduct[index].cartCount =
                                            (logic.relatedProduct[index].cartCount ?? 0) - 1,
                                        logic.update(),
                                      }).catchError((e) {
                                        logic.relatedProduct[index].isDecrease = false;
                                        logic.update();
                                      });
                                    },
                                    productModel: logic.relatedProduct[index],));
                            },),
                        ),
                      ],

                      20.verticalSpace,


                    ]else...[
                      (Get.height/3).verticalSpace,
                      const NotFound()
                    ],
                  ],

                ],),
            ),
          );
        },
      ),
    );
  }
}
