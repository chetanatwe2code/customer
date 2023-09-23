import 'package:flutter/material.dart';
import 'package:indiakinursery/utils/price_converter.dart';
import 'package:intl/intl.dart';
import 'package:indiakinursery/utils/string_extensions.dart';
import 'package:indiakinursery/view/widget/product/grid_product_view.dart';
import '../../../core/routes.dart';
import '../../../model/OrderModel.dart';
import '../../../theme/app_colors.dart';
import '../../../utils/string_helper.dart';
import '../../order/logic.dart';
import '../common_image.dart';
import '../small_dot.dart';
import 'package:get/get.dart';

class OrderHistoryView extends StatelessWidget {
  final OrderModel? orderModel;
  const OrderHistoryView({Key? key,this.orderModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String productImage = StringHelper.fistValueOfCommaSeparated(value: orderModel?.coverImage ?? orderModel?.allImagesUrl);
    if(productImage.isEmpty){
      productImage = StringHelper.defaultProductImage;
    }

    double? height = 100.0;
    OrderStatusCode orderStatusCode = getStatusCode(status: orderModel?.statusOrder);
    Color? statusColor = getStatusColor(orderStatusCode);
    return InkWell(
      onTap: (){
        Get.toNamed(rsOrderPage,arguments: { "order_id" : orderModel?.orderId??"" });
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          color: AppColors.whiteColor(),
          boxShadow: boxShadow()
        ),
        height: height,
       // padding: EdgeInsets.symmetric(horizontal: 10.r,vertical: 8),
        margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height,
              child: Stack(
                children: [
                  CommonImage(
                    imageUrl: productImage,
                    width: height,
                    height: height,
                    radius: 10,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.blackColor().withOpacity(0.5),
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          padding: const EdgeInsets.only(right: 10,left: 5),
                          child: Center(child: Text("${orderModel?.onlyThisOrderProductQuantity??1} Item",
                            style: TextStyle(
                                color: AppColors.whiteColor(),
                              fontSize: 12
                            ),))))
                ],
              ),
            ),
            const SizedBox(width: 10,),
            Flexible(
              child: SizedBox(
                height: height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text("Order#",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold
                              ),),
                            Text(orderModel?.orderId ?? "",
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold
                              ),),
                          ],
                        ),
                        if(orderModel?.deliveryVerifyCode != null
                            && orderStatusCode != OrderStatusCode.negative
                            && orderStatusCode != OrderStatusCode.four)...[
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                Text("OTP:".toUpperCase(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10,
                                    color: AppColors.textColor(),
                                    letterSpacing: -0.4,
                                  ),
                                ),
                                SizedBox(width: 5,),
                                Text("${orderModel?.deliveryVerifyCode ?? ""}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: AppColors.primary,
                                    letterSpacing: -0.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),

                    const SizedBox(height: 5,),
                    Text((orderModel?.verientName ?? "").toCapitalizeFirstLetter(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: AppColors.textColor(),
                        letterSpacing: -0.4,
                      ),
                    ),
                    const SizedBox(height: 10,),

                    Row(
                      children: [
                        Row(
                          children: [
                            Text(
                              "\u{20B9} ${PriceConverter.removeDecimalZeroFormat(orderModel?.onlyThisOrderProductTotal??0.0)}",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: orderStatusCode == OrderStatusCode.four ? AppColors.primary : AppColors.redColor(),
                                letterSpacing: -0.4,
                              ),
                            ),
                            if(orderModel?.paymentMode == "cod")...[
                              const SizedBox(width: 10,),
                               SmallDot(color: orderStatusCode == OrderStatusCode.four ? AppColors.primary : AppColors.redColor(),),
                              const SizedBox(width: 5,),
                              Text(
                                orderStatusCode == OrderStatusCode.four ? "Paid" :
                                (orderModel?.paymentMode??"").toUpperCase(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  color: AppColors.textColor(),
                                  letterSpacing: -0.4,
                                ),
                              ),
                            ]
                          ],
                        ),
                        const SizedBox(width: 10,),
                        Container(
                          decoration: BoxDecoration(
                              color: statusColor.withOpacity(0.1),
                              borderRadius: const BorderRadius.all(Radius.circular(10))
                          ),
                          margin: const EdgeInsets.only(top: 2,bottom: 2),
                          padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 2),
                          child: Row(
                            children: [
                              Text(getStatusName(orderStatusCode),
                                style: TextStyle(
                                    color: statusColor,
                                    fontSize: 10
                                ),),
                            ],
                          ),
                        )
                      ],
                    ),

                    const Spacer(),


                    Padding(
                      padding: const EdgeInsets.only(top: 2,bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if(orderModel?.orderDate?.isNotEmpty ?? false)
                            Text("Order: ${(orderModel?.orderDate??"").toDateDMMMYY()}",  style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                              color: AppColors.textColor().withOpacity(0.6),
                              letterSpacing: -0.4,
                            ),),
                          if(orderModel?.deliveryDate?.isNotEmpty ?? false)
                            Text(" | ${orderStatusCode == OrderStatusCode.four ? "Delivered" : "Exp. Delivery"}: ${(orderModel?.deliveryDate??"").toDateDMMMYY()}",  style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: AppColors.textColor(),
                              letterSpacing: -0.4,
                            ),),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
