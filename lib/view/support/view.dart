import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:indiakinursery/view/widget/common_material_button.dart';
import 'package:indiakinursery/view/widget/input_field/common_input_field.dart';

import '../../theme/app_colors.dart';
import '../../utils/string_helper.dart';
import '../login/view.dart';
import 'logic.dart';

class SupportPage extends GetView<SupportLogic> {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery
        .of(context)
        .size;
    bool isSmall = !isLargeScreen(media);
    return Scaffold(
      appBar: AppBar(title: Text("Help & Support".tr),elevation: 0,),
      body: Stack(
        children: [

          Container(
            height: kToolbarHeight*3,
            color: Theme.of(context).primaryColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                20.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Need Help".tr,
                    style: const TextStyle(
                      fontSize: 17,
                      color: Colors.white70,
                      fontWeight: FontWeight.w300
                    ),),
                  ],
                ),

                5.verticalSpace,

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    const Text("24 × 7",
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.w500

                      ),),

                    10.horizontalSpace,

                    Text("Support".tr,
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w500

                      ),),
                  ],
                ),

                20.verticalSpace,

                if(StringHelper.customerSupportNo.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(Icons.phone,color: Colors.white,size: 15,),
                      10.horizontalSpace,
                      Text(StringHelper.customerSupportNo,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                            fontWeight: FontWeight.w500

                        ),),
                    ],
                  ),
                ),

              ],
            ),
          ),

          Container(
            margin: const EdgeInsets.only(top: kToolbarHeight*2),
            width: Get.width,
            decoration: BoxDecoration(
              color: AppColors.whiteColor(),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: isSmall ? 20 : 120,vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  30.verticalSpace,

                  Text("Support Message".tr,
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                  ),),

                  50.verticalSpace,

                  if(controller.orderId != null)...[
                      const Text("Order Id"),

                      5.verticalSpace,

                      CommonInputField(
                        textController: controller.orderIdController,
                        enabled: false,
                      ),

                     25.verticalSpace,
                  ],


                  Text("Subject".tr,style: TextStyle(fontSize: isSmall ? 14 : 10.sp),),

                  5.verticalSpace,

                  CommonInputField(
                    textController: controller.subjectController,
                  ),

                  25.verticalSpace,

                  Text("Your Query".tr,style: TextStyle(fontSize: isSmall ? 14 : 10.sp),),

                  5.verticalSpace,

                  CommonInputField(
                    maxLine: 5,
                    textController: controller.issueController,
                  ),

                  40.verticalSpace,

                  CommonMaterialButton(
                    text: "Submit".tr,
                    onTap: (){
                      controller.submitNow();
                    },
                    height: 50.h,
                    fontSize: 12.sp,
                    color: AppColors.primaryColor(),
                    fontColor: AppColors.whiteColor(),
                  )

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
