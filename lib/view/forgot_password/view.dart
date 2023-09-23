import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:indiakinursery/utils/assets.dart';

import '../../core/routes.dart';
import '../../theme/app_colors.dart';
import '../login/view.dart';
import '../widget/common_material_button.dart';
import '../widget/input_field/common_input_field.dart';
import 'logic.dart';

class ForgotPasswordPage extends GetView<ForgotPasswordLogic> {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery
        .of(context)
        .size;
    bool isSmall = !isLargeScreen(media);
    return Container(
      color: Colors.white,
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.blueGrey.withOpacity(0.1),
          body: isSmall ? _buildSmallScreen(context) : _buildLargeScreen(context,media)
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        color: Colors.blueGrey.withOpacity(0.1),
        child: Stack(
          children: [

            SizedBox(
                height: Get.height,
                child: Column(
                  children: [
                    Image.asset(appBg2,
                        width: Get.width),

                    // const Spacer(),
                    //
                    // Image.asset(appBg,
                    //   width: Get.width),
                  ],
                )),

            SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    SizedBox(height: 150.h,),

                    Image.asset(appLogo2, width: 120.w,),

                    40.verticalSpace,

                    Row(
                      children: [
                        Flexible(
                          child: Text("Forgot Your Password".tr,
                            style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.bold
                            ),),
                        ),
                      ],
                    ),

                    const SizedBox(height: 7,),

                    Row(
                      children: [
                        Flexible(
                          child: Text("Forgot Message".tr,
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w300
                            ),),
                        ),
                      ],
                    ),

                    40.verticalSpace,

                    CommonInputField(
                      hintText: 'Enter email',
                      labelText: "Email",
                      keyboardType: TextInputType.emailAddress,
                      textController: controller.emailController,
                      suffixIcon: const Icon(Icons.email),
                    ),

                    10.verticalSpace,

                    SizedBox(height: 25.h,),


                    Obx(() {
                      return CommonMaterialButton(text: "Get OTP".tr,
                          color: AppColors.primaryColor(),
                          borderRadius: 5,
                          height: 50.h,
                          fontSize: 14.sp,
                          fontColor: AppColors.whiteColor(),
                          isLoading: controller.apiProcess.value,
                          onTap: () {
                            controller.forgotPassword(context: context);
                          });
                    }),

                    40.verticalSpace,

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Have remembered".tr,
                          style: TextStyle(
                              color: AppColors.text2,
                              fontSize: 16.sp
                          ),),

                        InkWell(
                          onTap: (){
                            Get.back();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text("Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.text2,
                                  fontSize: 15.sp
                              ),),
                          ),
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
    );
  }

  Widget _buildLargeScreen(BuildContext context,Size media){
    double width = getScreenPadding(media);
    return Stack(
      children: [

        Image.asset(appBg2,
            width: Get.width,fit: BoxFit.fitWidth,),

        SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: width),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                SizedBox(height: Get.height * 0.35,),

                Row(
                  children: [
                    Flexible(
                      child: Text("Forgot Your Password".tr,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                        ),),
                    ),
                  ],
                ),

                const SizedBox(height: 7,),

                Row(
                  children: [
                    Flexible(
                      child: Text("Forgot Message".tr,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300
                        ),),
                    ),
                  ],
                ),

                40.verticalSpace,

                CommonInputField(
                  hintText: 'Enter email',
                  labelText: "Email",
                  keyboardType: TextInputType.emailAddress,
                  textController: controller.emailController,
                  suffixIcon: const Icon(Icons.email),
                ),

                10.verticalSpace,

                SizedBox(height: 25.h,),


                Obx(() {
                  return CommonMaterialButton(text: "Get OTP".tr,
                      color: AppColors.primaryColor(),
                      borderRadius: 5,
                      height: 50,
                      fontSize: 14,
                      fontColor: AppColors.whiteColor(),
                      isLoading: controller.apiProcess.value,
                      onTap: () {
                        controller.forgotPassword(context: context);
                      });
                }),

                40.verticalSpace,

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Have remembered".tr,
                      style: const TextStyle(
                          color: AppColors.text2,
                          fontSize: 14
                      ),),

                    InkWell(
                      onTap: (){
                        Get.back();
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text("Login",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.text2,
                              fontSize: 14
                          ),),
                      ),
                    ),
                  ],
                ),


              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSmallScreen(BuildContext context){
    return Stack(
      children: [

        SizedBox(
            height: Get.height,
            child: Column(
              children: [
                Image.asset(appBg2,
                    width: Get.width),

                // const Spacer(),
                //
                // Image.asset(appBg,
                //   width: Get.width),
              ],
            )),

        SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                SizedBox(height: 150.h,),

                Image.asset(appLogo2, width: 120.w,),

                40.verticalSpace,

                Row(
                  children: [
                    Flexible(
                      child: Text("Forgot Your Password".tr,
                        style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold
                        ),),
                    ),
                  ],
                ),

                const SizedBox(height: 7,),

                Row(
                  children: [
                    Flexible(
                      child: Text("Forgot Message".tr,
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w300
                        ),),
                    ),
                  ],
                ),

                40.verticalSpace,

                CommonInputField(
                  hintText: 'Enter email',
                  labelText: "Email",
                  keyboardType: TextInputType.emailAddress,
                  textController: controller.emailController,
                  suffixIcon: const Icon(Icons.email),
                ),

                10.verticalSpace,

                SizedBox(height: 25.h,),


                Obx(() {
                  return CommonMaterialButton(text: "Get OTP".tr,
                      color: AppColors.primaryColor(),
                      borderRadius: 5,
                      height: 50.h,
                      fontSize: 14.sp,
                      fontColor: AppColors.whiteColor(),
                      isLoading: controller.apiProcess.value,
                      onTap: () {
                        controller.forgotPassword(context: context);
                      });
                }),

                40.verticalSpace,

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Have remembered".tr,
                      style: TextStyle(
                          color: AppColors.text2,
                          fontSize: 16.sp
                      ),),

                    InkWell(
                      onTap: (){
                        Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text("Login",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.text2,
                              fontSize: 15.sp
                          ),),
                      ),
                    ),
                  ],
                ),


              ],
            ),
          ),
        ),
      ],
    );
  }

}
