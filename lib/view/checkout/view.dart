import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:indiakinursery/utils/price_converter.dart';
import 'package:indiakinursery/utils/string_extensions.dart';
import 'package:indiakinursery/view/checkout/widget/confirm_order.dart';

import '../../controller/checkout_logic.dart';
import '../../theme/app_colors.dart';
import '../login/view.dart';
import '../widget/common_material_button.dart';
import '../widget/product/checkout_product_view.dart';
import '../widget/product/grid_product_view.dart';

class CheckoutPage extends GetView<CheckoutLogic> {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery
        .of(context)
        .size;
    bool isSmall = !isLargeScreen(media);
    controller.initData();
    return Container(
      color: Colors.white,
      child: Scaffold(
        appBar: AppBar(title: Text("Checkout Cart".tr)),
        backgroundColor: Colors.blueGrey.withOpacity(0.1),
        bottomNavigationBar: Container(
          height: 60.h,
          margin: isSmall ? const EdgeInsets.symmetric(horizontal: 10)  : const EdgeInsets.symmetric(horizontal: 100),
          child: GetBuilder<CheckoutLogic>(builder: (logic) {
            return Column(
              children: [
                if(logic.vendorProducts.isNotEmpty)
                  CommonMaterialButton(
                    color: AppColors.primaryColor(),
                    borderRadius: 5,
                    height: isSmall ? 50 : 60,
                    onTap: () {
                      logic.clearPincodeError();
                      Get.bottomSheet(
                        ConfirmOrder(paddingTop: MediaQuery
                            .of(context)
                            .padding
                            .top),
                        isScrollControlled: true,
                        barrierColor: Colors.transparent,
                        isDismissible: false,
                      ).then((value) => {
                       // logic.clearPincodeError(),
                      });
                    },
                    text: "Order now".tr,
                    label: Row(
                      children: [
                        Text("Order now".tr,
                          style: TextStyle(
                          color: AppColors.whiteColor(),
                            fontSize: isSmall ? 14 : 16,
                          letterSpacing: -0.4,
                          fontWeight: FontWeight.w400,
                        ),),
                        40.horizontalSpace,
                        Text("|", style: TextStyle(
                          color: AppColors.whiteColor(),
                          fontSize: isSmall ? 14 : 16,
                          letterSpacing: -0.4,
                          fontWeight: FontWeight.w400,
                        ),),
                        20.horizontalSpace,
                        Text("\u{20B9}${PriceConverter.removeDecimalZeroFormat(logic.totalAmount)}", style: TextStyle(
                          color: AppColors.whiteColor(),
                          fontSize: isSmall ? 14 : 16,
                          letterSpacing: -0.4,
                          fontWeight: FontWeight.w400,
                        ),),
                      ],
                    ),
                  )
              ],
            );
          }),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: isSmall ? 10 : 100,vertical: isSmall ? 10 : 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// cart
                GetBuilder<CheckoutLogic>(
                  assignId: true,
                  builder: (logic) {
                    return ListView.builder(
                      itemCount: logic.vendorProducts.length,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
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
                              const SizedBox(height: 10,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${logic.vendorProducts[i].ownerName}".toCapitalizeFirstLetter(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17
                                      ),),
                                    if((logic.notAvailableIds.contains("${logic.vendorProducts[i].vendorId??""}")))...[
                                      5.verticalSpace,
                                      Text("Service Unavailable".trParams({
                                        "pinCode": logic.addressModel?.pin ?? ""
                                      }),
                                        style: TextStyle(
                                            color: AppColors.redColor()
                                        ),),
                                    ],

                                  ],
                                ),
                              ),

                              ListView.builder(
                                itemCount: logic.vendorProducts[i].cartProducts!.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return CheckoutProductView(
                                    cartModel: logic.vendorProducts[i].cartProducts![index],
                                    onIncrease: () {
                                     // logic.increaseQuantity(index: index);
                                    },
                                    onDecrease: () {
                                      //logic.decreaseQuantity(index: index);
                                    },
                                    deleteCart: () {
                                       logic.deleteCart(index: index,i: i);
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
                    );
                  },
                ),

                /// order
                Divider(
                  height: 0.5,
                  thickness: 0.5,
                  color: AppColors.grayColor().withOpacity(0.2),
                ),
                7.verticalSpace,
                Text("Order Summary".tr,
                  style: TextStyle(
                      fontSize: isSmall ? 18 : 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor()
                  ),),
                7.verticalSpace,
                Divider(
                  height: 0.5,
                  thickness: 0.5,
                  color: AppColors.grayColor().withOpacity(0.2),
                ),
                10.verticalSpace,

                GetBuilder<CheckoutLogic>(
                  assignId: true,
                  builder: (logic) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        if(logic.totalDiscount > 0)
                          getSummaryRow(title: ("Total Discount Applied".tr),
                              color: AppColors.redColor(),
                              value: "- \u{20B9}${PriceConverter.removeDecimalZeroFormat(logic.totalDiscount)}"),


                        if(controller.totalGst > 0)
                          getSummaryRow(title: "Total Gst Applied".tr,
                              value: "\u{20B9}${PriceConverter.removeDecimalZeroFormat(controller.totalGst)}"),


                        if(controller.subTotal > 0)
                          getSummaryRow(title: "Sub Total Amount".tr,
                              value: "\u{20B9}${PriceConverter.removeDecimalZeroFormat(controller.subTotal)}"),


                        if(logic.totalDeliveryCharge > 0)
                          getSummaryRow(title: "Delivery Charge".tr,
                              value: "\u{20B9}${PriceConverter.removeDecimalZeroFormat(logic.totalDeliveryCharge)}"),

                        Divider(
                          height: 0.5,
                          thickness: 0.5,
                          color: AppColors.grayColor().withOpacity(0.2),
                        ),

                        10.verticalSpace,
                        getSummaryRow(title: "Payable amount".tr,
                            value: "\u{20B9}${PriceConverter.removeDecimalZeroFormat(logic.totalAmount)}",
                            isTotalRow: true),
                      ],
                    );
                  },
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget getSummaryRow(
    { required String title,
      Color? color,
      required String value,
      bool isTotalRow = false }) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Text(title,
            style: TextStyle(
                color: color ?? AppColors.textColor(),
                fontWeight: isTotalRow ? FontWeight.bold : null
            ),),
        ),

        Text(value,
          textAlign: TextAlign.right,
          style: TextStyle(
              color: color ?? AppColors.textColor(),
              fontWeight: isTotalRow ? FontWeight.bold : null
          ),),

      ],),
  );
}
