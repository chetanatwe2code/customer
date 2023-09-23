import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:indiakinursery/utils/assets.dart';
import 'package:indiakinursery/utils/string_helper.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/routes.dart';
import '../../theme/app_colors.dart';
import '../login/view.dart';
import '../widget/common_material_button.dart';
import '../widget/input_field/common_input_field.dart';
import 'logic.dart';

Future<void> launchMyUrl(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw 'Could not launch $url';
  }
}

class SignUpPage extends GetView<SignUpLogic> {
  const SignUpPage({Key? key}) : super(key: key);

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
    return Container(
      color: AppColors.whiteColor(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.blueGrey.withOpacity(0.1),
        //backgroundColor: AppColors.whiteColor(),
        body: Stack(
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

                    SizedBox(height: 200.h,),

                    Image.asset(appLogo2, width: 150.w,),

                    const SizedBox(height: 20,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Sign-Up",
                          style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold
                          ),),
                      ],
                    ),

                    50.verticalSpace,

                    // CommonInputField(
                    //   hintText: 'Name',
                    //   //labelText: "Name",
                    //   keyboardType: TextInputType.name,
                    //   textController: controller.nameController,
                    //   suffixIcon: const Icon(Icons.person),
                    // ),
                    //
                    // const SizedBox(height: 20,),
                    CommonInputField(
                      hintText: 'Email',
                      //labelText: "Email",
                      keyboardType: TextInputType.emailAddress,
                      textController: controller.emailController,
                      suffixIcon: const Icon(Icons.email),
                    ),

                    20.verticalSpace,

                    Obx(() {
                      return CommonInputField(
                        hintText: 'Password',
                        obscureText: controller.obscureText.value,
                        //labelText: "password",
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

                    // PrivacyPolicy
                    Obx(() {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          InkWell(
                            onTap: (){
                              controller.terms.value = !controller.terms.value;
                            },
                            child: Container(
                              height: 24.h,
                             width: 24.h,
                             decoration: BoxDecoration(
                               color: controller.terms.isTrue ? AppColors.primary : AppColors.whiteColor(),
                               border: Border.all(color:
                               controller.terms.isTrue ? AppColors.primary : AppColors.grayColor(),
                                   width: 2),
                               shape: BoxShape.circle,
                             ),
                              child: controller.terms.isTrue ? const Icon(Icons.check,color: Colors.white,) : null,
                            ),
                          ),

                          10.horizontalSpace,

                          InkWell(
                            onTap: (){
                              controller.terms.value = !controller.terms.value;
                            },
                            child: Text("Accept all the".tr,
                              style: TextStyle(
                                  color: AppColors.text2,
                                  fontSize: 16.sp
                              ),),
                          ),


                          TextButton(onPressed: (){
                            if(StringHelper.termAndConditionLink.isNotEmpty){
                              launchMyUrl(StringHelper.termAndConditionLink);
                            }
                          }, child: Text("Terms & Conditions.",
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 16.5.sp,
                              )))
                        ],
                      );
                    }),

                    5.verticalSpace,

                    Obx(() {
                      return CommonMaterialButton(text: "Sign-up",
                          color: AppColors.primaryColor(),
                          borderRadius: 5,
                          height: 50.h,
                          fontSize: 14.sp,
                          fontColor: AppColors.whiteColor(),
                          isLoading: controller.signUpProcess.value,
                          onTap: () {
                            controller.signUp(context: context);
                          });
                    }),

                    40.verticalSpace,

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("You Have a Account".tr,
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

                CommonInputField(
                  hintText: 'Email',
                  //labelText: "Email",
                  keyboardType: TextInputType.emailAddress,
                  textController: controller.emailController,
                  suffixIcon: const Icon(Icons.email),
                ),

                20.verticalSpace,

                Obx(() {
                  return CommonInputField(
                    hintText: 'Password',
                    obscureText: controller.obscureText.value,
                    //labelText: "password",
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

                // PrivacyPolicy
                Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      InkWell(
                        onTap: (){
                          controller.terms.value = !controller.terms.value;
                        },
                        child: Container(
                          height: 24,
                          width: 24,
                          decoration: BoxDecoration(
                            color: controller.terms.isTrue ? AppColors.primary : AppColors.whiteColor(),
                            border: Border.all(color:
                            controller.terms.isTrue ? AppColors.primary : AppColors.grayColor(),
                                width: 2),
                            shape: BoxShape.circle,
                          ),
                          child: controller.terms.isTrue ? const Icon(Icons.check,color: Colors.white,) : null,
                        ),
                      ),

                      const SizedBox(width: 10,),

                      InkWell(
                        onTap: (){
                          controller.terms.value = !controller.terms.value;
                        },
                        child: Text("Accept all the".tr,
                          style: const TextStyle(
                              color: AppColors.text2,
                              fontSize: 14
                          ),),
                      ),


                      TextButton(onPressed: (){
                        if(StringHelper.termAndConditionLink.isNotEmpty){
                          launchMyUrl(StringHelper.termAndConditionLink);
                        }
                      }, child: const Text("Terms & Conditions.",
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 14,
                          )))
                    ],
                  );
                }),

                5.verticalSpace,

                Obx(() {
                  return CommonMaterialButton(text: "Sign-up",
                      color: AppColors.primaryColor(),
                      borderRadius: 5,
                      height: 50,
                      fontSize: 14,
                      fontColor: AppColors.whiteColor(),
                      isLoading: controller.signUpProcess.value,
                      onTap: () {
                        controller.signUp(context: context);
                      });
                }),

                40.verticalSpace,

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("You Have a Account".tr,
                      style: TextStyle(
                          color: AppColors.text2,
                          fontSize: 14
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

                SizedBox(height: 200.h,),

                Image.asset(appLogo2, width: 150.w,),

                const SizedBox(height: 20,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Sign-Up",
                      style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold
                      ),),
                  ],
                ),

                50.verticalSpace,

                // CommonInputField(
                //   hintText: 'Name',
                //   //labelText: "Name",
                //   keyboardType: TextInputType.name,
                //   textController: controller.nameController,
                //   suffixIcon: const Icon(Icons.person),
                // ),
                //
                // const SizedBox(height: 20,),
                CommonInputField(
                  hintText: 'Email',
                  //labelText: "Email",
                  keyboardType: TextInputType.emailAddress,
                  textController: controller.emailController,
                  suffixIcon: const Icon(Icons.email),
                ),

                20.verticalSpace,

                Obx(() {
                  return CommonInputField(
                    hintText: 'Password',
                    obscureText: controller.obscureText.value,
                    //labelText: "password",
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

                // PrivacyPolicy
                Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      InkWell(
                        onTap: (){
                          controller.terms.value = !controller.terms.value;
                        },
                        child: Container(
                          height: 24.h,
                          width: 24.h,
                          decoration: BoxDecoration(
                            color: controller.terms.isTrue ? AppColors.primary : AppColors.whiteColor(),
                            border: Border.all(color:
                            controller.terms.isTrue ? AppColors.primary : AppColors.grayColor(),
                                width: 2),
                            shape: BoxShape.circle,
                          ),
                          child: controller.terms.isTrue ? const Icon(Icons.check,color: Colors.white,) : null,
                        ),
                      ),

                      10.horizontalSpace,

                      InkWell(
                        onTap: (){
                          controller.terms.value = !controller.terms.value;
                        },
                        child: Text("Accept all the".tr,
                          style: TextStyle(
                              color: AppColors.text2,
                              fontSize: 16.sp
                          ),),
                      ),


                      TextButton(onPressed: (){
                        if(StringHelper.termAndConditionLink.isNotEmpty){
                          launchMyUrl(StringHelper.termAndConditionLink);
                        }
                      }, child: Text("Terms & Conditions.",
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 16.5.sp,
                          )))
                    ],
                  );
                }),

                5.verticalSpace,

                Obx(() {
                  return CommonMaterialButton(text: "Sign-up",
                      color: AppColors.primaryColor(),
                      borderRadius: 5,
                      height: 50.h,
                      fontSize: 14.sp,
                      fontColor: AppColors.whiteColor(),
                      isLoading: controller.signUpProcess.value,
                      onTap: () {
                        controller.signUp(context: context);
                      });
                }),

                40.verticalSpace,

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("You Have a Account".tr,
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
