import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:indiakinursery/utils/assets.dart';

import '../../theme/app_colors.dart';
import '../login/view.dart';
import '../widget/common_material_button.dart';
import '../widget/input_field/common_input_field.dart';
import 'logic.dart';

class ChangePasswordPage extends GetView<ChangePasswordLogic> {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery
        .of(context)
        .size;
    bool isSmall = !isLargeScreen(media);
    return Container(
      color: AppColors.whiteColor(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.blueGrey.withOpacity(0.1),
        appBar: controller.isForgot ? null : AppBar(title: Text("Reset Password Toolbar Title".tr),),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: isSmall ? 20 : 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  if(isSmall)...[
                    const SizedBox(height: 50,),

                    Image.asset(appLogo2, width: 120,),

                    30.verticalSpace,
                  ]else...[
                    SizedBox(height: Get.height * 0.2,),
                  ],



                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Reset Password Heading".tr,
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold
                        ),),
                    ],
                  ),

                  30.verticalSpace,

                  Obx(() {
                    return CommonInputField(
                      hintText: 'Enter Password'.tr,
                      obscureText: controller.obscureText.value,
                      labelText: "Password".tr,
                      keyboardType: TextInputType.text,
                      textController: controller.passwordController,
                      suffixIcon: IconButton(onPressed: controller.toggle,
                          icon: Icon(
                            controller.obscureText.isTrue
                                ? Icons.visibility_off
                                : Icons
                                .visibility,
                          )),
                    );
                  }),

                  30.verticalSpace,

                  Obx(() {
                    return CommonInputField(
                      hintText: 'Confirm Password'.tr,
                      obscureText: controller.obscure2Text.value,
                      labelText: "Confirm Password".tr,
                      keyboardType: TextInputType.text,
                      textController: controller.confirmPasswordController,
                      suffixIcon: IconButton(onPressed: controller.toggle2,
                          icon: Icon(
                            controller.obscure2Text.isTrue
                                ? Icons.visibility_off
                                : Icons
                                .visibility,
                          )),
                    );
                  }),


                  80.verticalSpace,

                  Obx(() {
                    return CommonMaterialButton(text: "Reset Password".tr,
                        color: AppColors.primaryColor(),
                        borderRadius: 5,
                        height: 50.h,
                        fontSize: 12.sp,
                        fontColor: AppColors.whiteColor(),
                        isLoading: controller.apiProcess.value,
                        onTap: () {
                          controller.changePassword(context: context);
                        });
                  }),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
