import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:indiakinursery/theme/app_colors.dart';
import 'package:indiakinursery/utils/string_extensions.dart';
import 'package:indiakinursery/view/order/logic.dart';
import 'package:indiakinursery/view/order/widget/close_order.dart';
import 'package:indiakinursery/view/widget/api_error/not_data.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/routes.dart';
import '../../utils/price_converter.dart';
import '../login/view.dart';
import '../widget/order/show_status.dart';
import '../widget/product/grid_product_view.dart';
import '../widget/small_dot.dart';
import 'widget/product.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery
        .of(context)
        .size;
    bool isSmall = !isLargeScreen(media);
    return Scaffold(
      appBar: AppBar(title: Text("Order Detail".tr),
        actions: [
          GetBuilder<OrderLogic>(
            assignId: true,
            builder: (logic) {
              return IconButton(onPressed: () {
                Get.toNamed(rsSupportPage,
                    arguments: { "order_id": logic
                        .orderId});
              }, icon: const Icon(Icons.support_agent_outlined),);
            },
          )
        ],),
      body: SingleChildScrollView(
        child: Padding(
          padding: isSmall ? const EdgeInsets.all(15.0) : const EdgeInsets.symmetric(horizontal: 120,vertical: 50),
          child: GetBuilder<OrderLogic>(
            assignId: true,
            builder: (logic) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  if(logic.apiProcess)...[
                    Shimmer.fromColors(
                      baseColor: AppColors.shimmerBaseColor(),
                      highlightColor: AppColors.shimmerHighlightColor(),
                      child: Column(
                        children: [
                          20.verticalSpace,

                          const Row(
                            children: [
                              Text("Order#",
                                style: TextStyle(
                                    fontSize: 19,
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold
                                ),),
                            ],
                          ),

                          5.verticalSpace,

                          Row(
                            children: [
                              Text("Order: 00-00-0000", style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 10,
                                color: AppColors.textColor().withOpacity(0.6),
                                letterSpacing: -0.4,
                              ),),
                            ],
                          ),

                          /// order status
                          20.verticalSpace,
                          ShowStatus(
                            list: [
                              StepModel(name: "####", isCompleted: false),
                              StepModel(name: "####", isCompleted: false),
                              StepModel(name: "####", isCompleted: false),
                              StepModel(name: "####", isCompleted: false),
                            ],
                          ),

                          /// product
                          40.verticalSpace,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text("Product Details".tr,
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textColor()
                                ),),

                              10.verticalSpace,


                              for(int index = 0; index < 2; index++)...[
                                const OrderProduct(),
                              ]
                            ],
                          ),

                          /// Delivery info
                          20.verticalSpace,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text("Delivery Details".tr,
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textColor()
                                ),),

                              10.verticalSpace,

                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.whiteColor(),
                                  boxShadow: boxShadow(),
                                ),
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [


                                    Text("Delivery Location".tr,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.text2
                                      ),),

                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 24,
                                            width: 24,
                                            decoration: BoxDecoration(
                                                color: AppColors.darkPrimary
                                                    .withOpacity(
                                                    0.1),
                                                shape: BoxShape.circle
                                            ),
                                            child: const Icon(
                                              Icons.delivery_dining,
                                              color: AppColors.darkPrimary,
                                              size: 13,),
                                          ),

                                          10.horizontalSpace,

                                          const Text("-- -- - --- ----",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.text2
                                            ),),
                                        ],
                                      ),
                                    ),

                                    20.verticalSpace,

                                    Text("Contact Info".tr,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.text2
                                      ),),

                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 24,
                                            width: 24,
                                            decoration: BoxDecoration(
                                                color: AppColors.primary
                                                    .withOpacity(
                                                    0.1),
                                                shape: BoxShape.circle
                                            ),
                                            child: const Icon(Icons.person,
                                              color: AppColors.primary,
                                              size: 13,),
                                          ),
                                          10.horizontalSpace,

                                          const Text("---",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.text2
                                            ),),
                                        ],
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 24,
                                            width: 24,
                                            decoration: BoxDecoration(
                                                color: AppColors.primary
                                                    .withOpacity(
                                                    0.1),
                                                shape: BoxShape.circle
                                            ),
                                            child: const Icon(Icons.phone,
                                              color: AppColors.primary,
                                              size: 13,),
                                          ),
                                          10.horizontalSpace,

                                          const Text("----",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.text2
                                            ),),
                                        ],
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 24,
                                            width: 24,
                                            decoration: BoxDecoration(
                                                color: AppColors.primary
                                                    .withOpacity(
                                                    0.1),
                                                shape: BoxShape.circle
                                            ),
                                            child: const Icon(Icons.mail,
                                              color: AppColors.primary,
                                              size: 13,),
                                          ),
                                          10.horizontalSpace,

                                          const Text("----",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.text2
                                            ),),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),

                            ],
                          ),

                          /// Amount info
                          20.verticalSpace,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text("Amount Summary".tr,
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textColor()
                                ),),

                              10.verticalSpace,

                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.whiteColor(),
                                  boxShadow: boxShadow(),
                                ),
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    5.verticalSpace,
                                    Row(
                                      children: [
                                        const Text("Payment Mode",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.text2
                                          ),
                                        ),
                                        5.horizontalSpace,
                                        const Text("---",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.text2
                                          ),
                                        ),
                                        15.horizontalSpace,
                                        SmallDot(color: logic.orderStatusCode ==
                                            OrderStatusCode.four ? AppColors
                                            .primary : AppColors.redColor(),),
                                        5.horizontalSpace,
                                        Text("###",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            color: AppColors.redColor(),
                                            letterSpacing: -0.4,
                                          ),
                                        ),
                                      ],
                                    ),
                                    5.verticalSpace,
                                    const Divider(),


                                    // Total Gst Applied
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.h),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Text("Total Gst Applied".tr,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.text2
                                            ),),

                                          Text("\u{20B9} ${0.0}",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.textColor()
                                            ),),
                                        ],
                                      ),
                                    ),

                                    /// Sub Total Amount
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.h),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Text("Sub Total Amount".tr,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.text2
                                            ),),

                                          Text("\u{20B9} 0}",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.textColor()
                                            ),),
                                        ],
                                      ),
                                    ),

                                    // Delivery Charge
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.h),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Text("Delivery Charge".tr,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.text2
                                            ),),

                                          Text("\u{20B9} 0.0",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.textColor()
                                            ),),
                                        ],
                                      ),
                                    ),

                                    /// Grand Total
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.h),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Text("Grand Total".tr,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.text2
                                            ),),

                                          const Text("\u{20B9} 0.0",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.primary
                                            ),),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          30.verticalSpace,
                        ],
                      ),
                    )
                  ] else
                    ...[

                      if(logic.orderDetailsModel == null)...[
                        SizedBox(height: Get.height / 3,),
                        const NoData(
                          iconData: Icons.search_off,
                        )
                      ] else
                        ...[
                          20.verticalSpace,

                          Row(
                            children: [
                              const Text("Order#",
                                style: TextStyle(
                                    fontSize: 19,
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold
                                ),),
                              Text("${logic.orderId ?? ""}",
                                style: const TextStyle(
                                    fontSize: 19,
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold
                                ),),
                            ],
                          ),

                          5.verticalSpace,

                          Row(
                            children: [
                              if(logic.orderDetailsModel?.orderDetaile?[0]
                                  .orderDate?.isNotEmpty ?? false)
                                Text("Order: ${(logic.orderDetailsModel
                                    ?.orderDetaile?[0].orderDate ?? "")
                                    .toDateDMMMYY()}", style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10,
                                  color: AppColors.textColor().withOpacity(0.6),
                                  letterSpacing: -0.4,
                                ),),

                              if(logic.orderDetailsModel?.orderDetaile?[0]
                                  .deliveryDate?.isNotEmpty ?? false)
                                Text(" | ${logic.orderStatusCode ==
                                    OrderStatusCode.four
                                    ? "Delivered"
                                    : "Exp. Delivery"}: ${(logic
                                    .orderDetailsModel?.orderDetaile?[0]
                                    .deliveryDate ?? "").toDateDMMMYY()}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: AppColors.textColor(),
                                    letterSpacing: -0.4,
                                  ),),
                            ],
                          ),

                          /// order status
                          20.verticalSpace,
                          ShowStatus(
                            list: logic.totalSteps,
                            orderRejected: logic.orderCancelled,
                            isSmall: isSmall,
                          ),

                          /// product Details
                          40.verticalSpace,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              if(logic.orderDetailsModel?.orderProductDetaile
                                  ?.isNotEmpty ?? false)
                                Text("Product Details".tr,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textColor()
                                  ),),

                              10.verticalSpace,


                              for(int index = 0; index <
                                  ((logic.orderDetailsModel
                                      ?.orderProductDetaile ??
                                      [])
                                      .length); index++)...[
                                OrderProduct(model: logic.orderDetailsModel!
                                    .orderProductDetaile?[index],
                                  orderStatus: logic.orderDetailsModel
                                      ?.orderDetaile?[0].statusOrder ?? "",
                                ),
                              ]
                            ],
                          ),

                          /// Delivery Details
                          20.verticalSpace,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text("Delivery Details".tr,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textColor()
                                    ),),

                                  if(logic.orderStatusCode !=
                                      OrderStatusCode.negative &&
                                      logic.orderStatusCode !=
                                          OrderStatusCode.four
                                  )
                                    InkWell(
                                      onTap: logic.closeProcess.value
                                          ? null
                                          : () {
                                        logic.closeOrder(
                                            orderID: "${logic.orderId ?? ""}",
                                            callBack: () {});
                                        // Get.bottomSheet(
                                        //   CloseOrder(orderID: "${controller.orderId ?? ""}"),
                                        //   isScrollControlled: true,
                                        //   barrierColor: Colors.transparent,
                                        //   isDismissible: false,
                                        // );

                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppColors.textColor()),
                                              borderRadius: BorderRadius
                                                  .circular(5)
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 2),
                                          child: Text("Cancel the order",
                                            style: TextStyle(
                                                color: AppColors.textColor()
                                            ),)),
                                    ),
                                ],
                              ),

                              10.verticalSpace,

                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.whiteColor(),
                                  boxShadow: boxShadow(),
                                ),
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Text("Delivery Location".tr,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.text2
                                      ),),

                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Container(
                                            height: 24,
                                            width: 24,
                                            decoration: BoxDecoration(
                                                color: AppColors.darkPrimary
                                                    .withOpacity(
                                                    0.1),
                                                shape: BoxShape.circle
                                            ),
                                            child: const Icon(
                                              Icons.delivery_dining,
                                              color: AppColors.darkPrimary,
                                              size: 13,),
                                          ),

                                          10.horizontalSpace,

                                          Flexible(
                                            child: Text(
                                              ("${logic.orderDetailsModel
                                                  ?.orderDetaile?[0]
                                                  .address ?? ""} ${logic
                                                  .orderDetailsModel
                                                  ?.orderDetaile?[0]
                                                  .city ?? ""}, ${logic
                                                  .orderDetailsModel
                                                  ?.orderDetaile?[0]
                                                  .pinCode ?? ""}"),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.text2
                                              ),),
                                          ),
                                        ],
                                      ),
                                    ),

                                    20.verticalSpace,

                                    Text("Contact Info".tr,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.text2
                                      ),),

                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 24,
                                            width: 24,
                                            decoration: BoxDecoration(
                                                color: AppColors.primary
                                                    .withOpacity(
                                                    0.1),
                                                shape: BoxShape.circle
                                            ),
                                            child: const Icon(Icons.person,
                                              color: AppColors.primary,
                                              size: 13,),
                                          ),
                                          10.horizontalSpace,

                                          Text(logic.orderDetailsModel
                                              ?.orderDetaile?[0]
                                              .userName ?? "",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.text2
                                            ),),
                                        ],
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 24,
                                            width: 24,
                                            decoration: BoxDecoration(
                                                color: AppColors.primary
                                                    .withOpacity(
                                                    0.1),
                                                shape: BoxShape.circle
                                            ),
                                            child: const Icon(Icons.phone,
                                              color: AppColors.primary,
                                              size: 13,),
                                          ),
                                          10.horizontalSpace,

                                          Text(((logic.orderDetailsModel
                                              ?.orderDetaile?[0]
                                              .phoneNo ?? "")),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.text2
                                            ),),
                                        ],
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 24,
                                            width: 24,
                                            decoration: BoxDecoration(
                                                color: AppColors.primary
                                                    .withOpacity(
                                                    0.1),
                                                shape: BoxShape.circle
                                            ),
                                            child: const Icon(Icons.mail,
                                              color: AppColors.primary,
                                              size: 13,),
                                          ),
                                          10.horizontalSpace,

                                          Text(((logic.orderDetailsModel
                                              ?.orderDetaile?[0]
                                              .email ?? "")),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.text2
                                            ),),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),

                            ],
                          ),

                          /// Amount info
                          20.verticalSpace,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text("Amount Summary".tr,
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textColor()
                                ),),

                              10.verticalSpace,

                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.whiteColor(),
                                  boxShadow: boxShadow(),
                                ),
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    5.verticalSpace,
                                    Row(
                                      children: [
                                        const Text("Payment Mode",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.text2
                                          ),
                                        ),
                                        5.horizontalSpace,
                                        Text((logic.orderDetailsModel
                                            ?.orderDetaile?[0].paymentMode ??
                                            "cod").toUpperCase(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.text2
                                          ),
                                        ),
                                        15.horizontalSpace,
                                        SmallDot(color: logic.orderStatusCode ==
                                            OrderStatusCode.four ? AppColors
                                            .primary : AppColors.redColor(),),
                                        5.horizontalSpace,
                                        Text(
                                          logic.orderStatusCode ==
                                              OrderStatusCode.four
                                              ? "Paid"
                                              : "Unpaid".toUpperCase(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            color: logic.orderStatusCode ==
                                                OrderStatusCode.four ? AppColors
                                                .primary : AppColors.redColor(),
                                            letterSpacing: -0.4,
                                          ),
                                        ),
                                      ],
                                    ),
                                    5.verticalSpace,
                                    const Divider(),


                                    // Total Gst Applied
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.h),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Text("Total Gst Applied".tr,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.text2
                                            ),),

                                          Text("\u{20B9} ${PriceConverter
                                              .removeDecimalZeroFormat(
                                              logic.orderDetailsModel
                                                  ?.orderDetaile?[0]
                                                  .onlyThisProductGst ?? 0.0)}",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.textColor()
                                            ),),
                                        ],
                                      ),
                                    ),

                                    // /// Total Discount Applied
                                    // Padding(
                                    //   padding: EdgeInsets.only(top: 10.h),
                                    //   child: Row(
                                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //     children: [
                                    //       Text("Total Discount Applied".tr,
                                    //         style: const TextStyle(
                                    //             fontWeight: FontWeight.w400,
                                    //             color: AppColors.text2
                                    //         ),),
                                    //
                                    //       Text("\u{20B9} ${double.tryParse(controller.orderDetailsModel?.orderDetaile?[0].totalDiscount??"0.0")}",
                                    //         style: TextStyle(
                                    //             fontSize: 15,
                                    //             fontWeight: FontWeight.bold,
                                    //             color: AppColors.textColor()
                                    //         ),),
                                    //     ],
                                    //   ),
                                    // ),

                                    /// Sub Total Amount
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.h),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Text("Sub Total Amount".tr,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.text2
                                            ),),

                                          Text("\u{20B9} ${PriceConverter
                                              .removeDecimalZeroFormat(
                                              logic.orderDetailsModel
                                                  ?.orderDetaile?[0]
                                                  .onlyThisOrderProductTotal ??
                                                  0.0)}",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.textColor()
                                            ),),
                                        ],
                                      ),
                                    ),

                                    // Delivery Charge
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.h),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Text("Delivery Charge".tr,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.text2
                                            ),),

                                          Text("\u{20B9} ${PriceConverter
                                              .removeDecimalZeroFormat(
                                              (logic.orderDetailsModel
                                                  ?.orderDetaile?[0]
                                                  .shippingCharges
                                                  ?? 0.0))}",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.textColor()
                                            ),),
                                        ],
                                      ),
                                    ),

                                    /// Grand Total
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.h),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Text("Grand Total".tr,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.text2
                                            ),),

                                          Text(
                                            "\u{20B9} ${logic.getGrandTotal()}",
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.primary
                                            ),),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          30.verticalSpace,
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
