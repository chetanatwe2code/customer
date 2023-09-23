import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:indiakinursery/utils/string_extensions.dart';
import 'package:shimmer/shimmer.dart';

import '../../controller/cart_controller.dart';
import '../../core/routes.dart';
import '../../theme/app_colors.dart';
import '../../utils/price_converter.dart';
import '../checkout/view.dart';
import '../login/view.dart';
import '../widget/api_error/no_internet.dart';
import '../widget/api_error/not_found.dart';
import '../widget/common_material_button.dart';
import '../widget/product/cart_product_view.dart';
import '../widget/product/grid_product_view.dart';
import '../widget/product/shimmer/cart_product_shimmer_view.dart';


class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery
        .of(context)
        .size;
    bool isSmall = !isLargeScreen(media);
    Get.find<CartController>().getCart();
    return Container(
      color: AppColors.whiteColor(),
      child: Scaffold(
        backgroundColor: Colors.blueGrey.withOpacity(0.1),
        appBar: AppBar(title: Text("Cart".tr),),
        bottomNavigationBar: Container(
          height: 60.h,
          margin: isSmall ? const EdgeInsets.symmetric(horizontal: 10)  : const EdgeInsets.symmetric(horizontal: 100),
          child: GetBuilder<CartController>(builder: (logic) {
            return Column(
              children: [

                if(logic.apiProgress)...[
                  Shimmer.fromColors(
                    baseColor: AppColors.shimmerBaseColor(),
                    highlightColor: AppColors.shimmerHighlightColor(),
                    enabled: true,
                    child: CommonMaterialButton(
                      color: AppColors.primaryColor().withOpacity(0.5),
                      borderRadius: 5,
                      onTap: () {
                        Get.toNamed(rsCheckoutPage);
                      },
                      label: Row(
                        children: [
                          Text("Proceed To Checkout".tr, style: TextStyle(
                            color: AppColors.whiteColor(),
                            fontSize: 14.sp,
                            letterSpacing: -0.4,
                            fontWeight: FontWeight.w400,
                          ),),
                          40.horizontalSpace,
                          Text("|", style: TextStyle(
                            color: AppColors.whiteColor(),
                            fontSize: 14.sp,
                            letterSpacing: -0.4,
                            fontWeight: FontWeight.w400,
                          ),),
                          20.horizontalSpace,
                          Text("\u{20B9}----", style: TextStyle(
                            color: AppColors.whiteColor(),
                            fontSize: 14.sp,
                            letterSpacing: -0.4,
                            fontWeight: FontWeight.w400,
                          ),),
                        ],
                      ),
                    ),
                  )
                ]else...[
                  if(logic.vendorProducts.isNotEmpty)
                    CommonMaterialButton(
                      color: AppColors.primaryColor(),
                      borderRadius: 5,
                      height: isSmall ? 50 : 60,
                      onTap: () {
                        Get.toNamed(rsCheckoutPage);
                      },
                      label: Row(
                        children: [
                          Text("Proceed To Checkout".tr, style: TextStyle(
                            color: AppColors.whiteColor(),
                            fontSize: isSmall ? 14 : 16,
                            letterSpacing: -0.4,
                            fontWeight: FontWeight.w400,
                          ),),
                          20.horizontalSpace,
                          Text("|", style: TextStyle(
                            color: AppColors.whiteColor(),
                            fontSize: isSmall ? 14 : 16,
                            letterSpacing: -0.4,
                            fontWeight: FontWeight.w400,
                          ),),
                          20.horizontalSpace,
                          Text("\u{20B9}${PriceConverter.removeDecimalZeroFormat(logic.subTotal+logic.totalDeliveryCharge)}", style: TextStyle(
                            color: AppColors.whiteColor(),
                            fontSize: isSmall ? 14 : 16,
                            letterSpacing: -0.4,
                            fontWeight: FontWeight.w400,
                          ),),
                        ],
                      ),
                    )
                ],
              ],
            );
          }),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            Get.find<CartController>().getCart();
          },
          child: GetBuilder<CartController>(
            assignId: true,
            builder: (logic) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  if(logic.noInternet)...[
                    NoInternet(
                      retry: (){
                        logic.getCart();
                      },
                    ),
                  ]else...[
                    if(logic.apiProgress)...[
                      const CartProductShimmerView(),
                    ]else...[
                      if(logic.vendorProducts.isNotEmpty)...[
                        /// Cart Product
                        Expanded(
                            child: ListView.builder(
                              itemCount: logic.vendorProducts.length,
                              padding: isSmall ? const EdgeInsets.all(15)  : const EdgeInsets.symmetric(horizontal: 100,vertical: 50),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int i) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.whiteColor(),
                                    boxShadow: boxShadow(),
                                  ),
                                  margin: const EdgeInsets.only(bottom: 15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("${logic.vendorProducts[i].ownerName}".toCapitalizeFirstLetter(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17
                                              ),),
                                          ],
                                        ),
                                      ),

                                      ListView.builder(
                                        itemCount: logic.vendorProducts[i].cartProducts!.length,
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return CartProductView(
                                            cartModel: logic.vendorProducts[i].cartProducts![index],
                                            onIncrease: () {
                                              logic.increaseQuantity(index: index,i: i);
                                            },
                                            onDecrease: () {
                                              logic.decreaseQuantity(index: index,i: i);
                                            },
                                            deleteCart: () {
                                              logic.deleteCart(index: index,fromView: true,i: i);
                                            },
                                          );
                                        },
                                      ),

                                      // Summary
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 10,),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 10),
                                            child: Text("Summary",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),),
                                          ),
                                          const SizedBox(height: 10,),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10),
                                            child: getSummaryRow(
                                              title: "Total GST",
                                              value: "\u{20B9}${PriceConverter.removeDecimalZeroFormat(logic.vendorProducts[i].gstAmount??0)}",
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10),
                                            child: getSummaryRow(
                                              title: "Sub Total",
                                              value: "\u{20B9}${PriceConverter.removeDecimalZeroFormat((logic.vendorProducts[i].priceXCartQtyAmount??0))}",
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10),
                                            child: getSummaryRow(
                                              title: "Delivery Charges",
                                              value: "\u{20B9}${PriceConverter.removeDecimalZeroFormat(logic.vendorProducts[i].deliveryCharges??0)}",
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10),
                                            child: getSummaryRow(
                                              title: "Total Amount",
                                              value: "\u{20B9}${PriceConverter.removeDecimalZeroFormat((logic.vendorProducts[i].priceXCartQtyAmount??0)+(logic.vendorProducts[i].deliveryCharges??0))}",
                                            ),
                                          ),
                                          const SizedBox(height: 10,),
                                        ],
                                      ),

                                    ],
                                  ),
                                );
                              },
                            )
                        ),
                      ]else...[
                        const NotFound(),
                      ]
                    ],
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
