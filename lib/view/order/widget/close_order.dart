import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:indiakinursery/view/order/logic.dart';

import '../../../theme/app_colors.dart';
import '../../widget/input_field/common_input_field.dart';

class CloseOrder extends GetView<OrderLogic> {
  final String? orderID;
  const CloseOrder({Key? key,this.orderID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      padding: EdgeInsets.all(20.r),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.shopping_bag,color: AppColors.iconColor(),),
                  5.horizontalSpace,
                  Text("Cancel the order",
                    style: TextStyle(
                        color: AppColors.textColor(),
                        fontWeight: FontWeight.bold
                    ),),
                ],
              ),
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.redColor().withOpacity(0.4),
                    shape: BoxShape.circle
                  ),
                  padding: const EdgeInsets.all(2),
                  child: Icon(Icons.close,color: AppColors.whiteColor(),),
                ),
              )
            ],
          ),

          15.verticalSpace,
          CommonInputField(
            hintText: 'Enter Reason',
            maxLength: 700,
            maxLine: 7,
            textController: controller.reasonController,
            keyboardType: TextInputType.name,
          ),

          30.verticalSpace,

          Obx(() {
            return InkWell(
              onTap: controller.closeProcess.value ? null : () {
                controller.closeOrder(orderID: orderID??"",callBack: (){
                  Get.back();
                  Navigator.pop(context);
                });
              },
              child:
              Container(
                  height: 50,
                  color: AppColors.redColor(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      if(controller.closeProcess.value)...[
                        const SizedBox(
                          height: (40) / 2,
                          width: (40) / 2,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        ),
                      ]else...[
                        Text("Cancel the order",
                          style: TextStyle(
                              color: AppColors.whiteColor(),
                              fontSize: 20
                          ),),
                        10.horizontalSpace,
                        Container(
                            height: 22,
                            width: 22,
                            decoration: BoxDecoration(
                                color: AppColors.whiteColor(),
                                shape: BoxShape.circle
                            ),
                            child: Icon(
                              Icons.shopping_bag, color: AppColors.iconColor(),
                              size: 15,)),
                      ],
                    ],
                    ////             ),
                  )),
            );
          }),

        ],
      ),
    );
  }
}
