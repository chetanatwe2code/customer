import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:indiakinursery/utils/assets.dart';

import '../../core/routes.dart';
import '../../theme/app_colors.dart';
import '../home/view.dart';
import '../widget/common_material_button.dart';
import '../widget/input_field/common_input_field.dart';
import '../widget/product/grid_product_view.dart';
import 'logic.dart';

/// phone tablet web
enum ScreenSize { phone, tablet, web }

int getGridCount(Size size){
  return size.width > 600 ? (size.width > 700 ? (size.width > 950 ? (size.width > 1100 ? 6 : 5) : 4) : 3) : 2;
}

double getScreenPadding(Size size){
  if(size.width > 600){
    if(size.width > 700){
      if(size.width > 950){
        if(size.width > 1100){
          return 150;
        }
        return 130;
      }
      return 100;
    }
    return 50;
  }
   return horizontalPadding;
}


bool isLargeScreen(Size size){
  return size.width > 600;
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // double size = 38.r;
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
                  ],
                )),

            isSmall ? _buildSmallScreen(context) : _buildLargeScreen(context,media)

            // SingleChildScrollView(
            //   child: Container(
            //     alignment: Alignment.center,
            //     padding: const EdgeInsets.only(left: 20, right: 20),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //
            //         SizedBox(height: Get.height*0.2,),
            //
            //         Image.asset(appLogo2, width: 150.w,),
            //
            //         20.verticalSpace,
            //
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Text("Login",
            //               style: TextStyle(
            //                   fontSize: 22.sp,
            //                   fontWeight: FontWeight.bold
            //               ),),
            //           ],
            //         ),
            //
            //         40.verticalSpace,
            //
            //         CommonInputField(
            //           hintText: 'Enter Email/Phone Number',
            //           //labelText: "Email/Phone Number",
            //           maxLength: 30,
            //           keyboardType: TextInputType.emailAddress,
            //           textController: controller.emailController,
            //           suffixIcon: const Icon(Icons.email),
            //         ),
            //
            //         30.verticalSpace,
            //
            //         Obx(() {
            //           return CommonInputField(
            //             hintText: 'Enter Password'.tr,
            //             obscureText: controller.obscureText.value,
            //            // labelText: "Password".tr,
            //             keyboardType: TextInputType.text,
            //             textController: controller.passwordController,
            //             suffixIcon: IconButton(onPressed: controller.toggle,
            //                 icon: Icon(
            //                   controller.obscureText.isTrue
            //                       ? Icons.visibility_off
            //                       : Icons
            //                       .visibility,
            //                 )),
            //           );
            //         }),
            //
            //         20.verticalSpace,
            //
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.end,
            //           children: [
            //             TextButton(onPressed: (){
            //               Get.toNamed(rsForgotPasswordPage,arguments: {"email" : controller.emailController.text});
            //             }, child: Text("Forgot Password".tr,
            //             style: TextStyle(
            //               fontSize: 14.sp,
            //             ),))
            //           ],
            //         ),
            //
            //         2.verticalSpace,
            //
            //         Obx(() {
            //           return CommonMaterialButton(text: "Login",
            //               color: AppColors.primaryColor(),
            //               borderRadius: 5,
            //               height: 50.h,
            //               fontSize: 14.sp,
            //               fontColor: AppColors.whiteColor(),
            //               isLoading: controller.loginProcess.value,
            //               onTap: () {
            //                 controller.login(context: context);
            //               });
            //         }),
            //
            //         20.verticalSpace,
            //
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Text("Don't Have a Account".tr,
            //               style: TextStyle(
            //                   color: AppColors.text2,
            //                   fontSize: 16.sp
            //               ),),
            //             2.horizontalSpace,
            //             InkWell(
            //               onTap: (){
            //                 Get.toNamed(rsSignUpPage);
            //               },
            //               child: Padding(
            //                 padding: const EdgeInsets.all(4.0),
            //                 child: Text("SignUp",
            //                   style: TextStyle(
            //                       fontWeight: FontWeight.bold,
            //                       color: AppColors.text2,
            //                       fontSize: 15.sp
            //                   ),),
            //               ),
            //             ),
            //           ],
            //         ),
            //
            //         40.verticalSpace,
            //
            //         InkWell(
            //           onTap: (){
            //             controller.signInWithGoogle();
            //           },
            //           child: Container(
            //             height: 50.h,
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular((5)),
            //               color: Colors.white,
            //               boxShadow: boxShadow(
            //                 color: Colors.grey,
            //                 blurRadius: 1,
            //                 offset: const Offset(0, 2), // Shadow position
            //               ),
            //             ),
            //             child: Row(
            //               mainAxisSize: MainAxisSize.min,
            //               children: [
            //                 SizedBox(width: 20.w,),
            //                 Image.asset(appGoogle,width: 24.w),
            //                 //Icon(FlutterRemix.google_fill,color: Color(0xFFE60023),),
            //                 SizedBox(width: 25.w,),
            //                 Text("Sign in with Google",
            //                   style: TextStyle(
            //                     color: const Color(0xFF555555),
            //                     fontWeight: FontWeight.w600,
            //                     fontSize: 14.sp
            //                   ),),
            //                 SizedBox(width: 20.w,),
            //               ],),
            //           ),
            //         ),
            //
            //         // Row(
            //         //   mainAxisAlignment: MainAxisAlignment.center,
            //         //   children: [
            //         //     // InkWell(
            //         //     //   onTap: (){
            //         //     //     controller.signInWithFacebook();
            //         //     //   },
            //         //     //   child: Container(
            //         //     //       height: size,
            //         //     //       width: size,
            //         //     //       decoration: const BoxDecoration(
            //         //     //         color: Color(0xFF3B5998),
            //         //     //         shape: BoxShape.circle
            //         //     //       ),
            //         //     //       child: Center(
            //         //     //         child: Icon(FlutterRemix.facebook_line,
            //         //     //         color: AppColors.whiteColor(),),
            //         //     //       )),
            //         //     // ),
            //         //     //
            //         //     // 15.horizontalSpace,
            //         //
            //         //     // InkWell(
            //         //     //   onTap: (){
            //         //     //     controller.signInWithGoogle();
            //         //     //   },
            //         //     //   child: Container(
            //         //     //       height: size,
            //         //     //       width: size,
            //         //     //       decoration: const BoxDecoration(
            //         //     //           color: Color(0xFFE60023),
            //         //     //           shape: BoxShape.circle
            //         //     //       ),
            //         //     //       child: Center(
            //         //     //         child: Icon(FlutterRemix.google_line,
            //         //     //           color: AppColors.whiteColor(),),
            //         //     //       )),
            //         //     // ),
            //         //
            //         //     // 15.horizontalSpace,
            //         //     //
            //         //     // Container(
            //         //     //     height: size,
            //         //     //     width: size,
            //         //     //     decoration: const BoxDecoration(
            //         //     //         color: Color(0xFF00ACEE),
            //         //     //         shape: BoxShape.circle
            //         //     //     ),
            //         //     //     child: Center(
            //         //     //       child: Icon(FlutterRemix.twitter_line,
            //         //     //         color: AppColors.whiteColor(),),
            //         //     //     )),
            //         //     //
            //         //     // 15.horizontalSpace,
            //         //     //
            //         //     // Container(
            //         //     //     height: size,
            //         //     //     width: size,
            //         //     //     decoration: const BoxDecoration(
            //         //     //       gradient: LinearGradient(
            //         //     //         colors: [
            //         //     //           Color(0xFF833AB4),
            //         //     //           Color(0xFFC13584),
            //         //     //           Color(0xFFE1306C),
            //         //     //           Color(0xFFFF4960),
            //         //     //           Color(0xFFFF512F),
            //         //     //           Color(0xFFFF6B00),
            //         //     //           Color(0xFFFF9500),
            //         //     //           Color(0xFFFFCC00),
            //         //     //         ],
            //         //     //         begin: Alignment.topLeft,
            //         //     //         end: Alignment.bottomRight,
            //         //     //       ),
            //         //     //       shape: BoxShape.circle,
            //         //     //     ),
            //         //     //
            //         //     //     child: Center(
            //         //     //       child: Icon(FlutterRemix.instagram_line,
            //         //     //         color: AppColors.whiteColor(),),
            //         //     //     )),
            //         //   ],
            //         // ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildLargeScreen(BuildContext context,Size media) {
   double width = getScreenPadding(media);
    return Stack(
      children: [

        Image.asset(appBg2,
            width: Get.width,fit: BoxFit.fitWidth,),

        SingleChildScrollView(
          child: GetBuilder<LoginLogic>(
            assignId: true,
            builder: (logic) {
              return Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: width),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    SizedBox(height: Get.height * 0.35,),

                    CommonInputField(
                      hintText: 'Enter Email/Phone Number',
                      //labelText: "Email/Phone Number",
                      maxLength: 30,
                      keyboardType: TextInputType.emailAddress,
                      textController: logic.emailController,
                      suffixIcon: const Icon(Icons.email),
                    ),

                    const SizedBox(height: 30,),

                    Obx(() {
                      return CommonInputField(
                        hintText: 'Enter Password'.tr,
                        obscureText: logic.obscureText.value,
                        // labelText: "Password".tr,
                        keyboardType: TextInputType.text,
                        textController: logic.passwordController,
                        suffixIcon: IconButton(onPressed: logic.toggle,
                            icon: Icon(
                              logic.obscureText.isTrue
                                  ? Icons.visibility_off
                                  : Icons
                                  .visibility,
                            )),
                      );
                    }),

                    const SizedBox(height: 30,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(onPressed: () {
                          Get.toNamed(rsForgotPasswordPage,
                              arguments: {
                                "email": logic.emailController.text
                              });
                        }, child: Text("Forgot Password".tr,
                          style: const TextStyle(
                            fontSize: 14,
                          ),))
                      ],
                    ),

                    const SizedBox(height: 2,),

                    Obx(() {
                      return CommonMaterialButton(text: "Login",
                          color: AppColors.primaryColor(),
                          borderRadius: 5,
                          height: 50,
                          fontSize: 14,
                          fontColor: AppColors.whiteColor(),
                          isLoading: logic.loginProcess.value,
                          onTap: () {
                            logic.login(context: context);
                          });
                    }),

                    const SizedBox(height: 40,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't Have a Account".tr,
                          style: const TextStyle(
                              color: AppColors.text2,
                              fontSize: 14
                          ),),
                        const SizedBox(width: 2,),
                        InkWell(
                          onTap: () {
                            Get.toNamed(rsSignUpPage);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text("SignUp",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.text2,
                                  fontSize: 14
                              ),),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30,),

                    InkWell(
                      onTap: () {
                        logic.signInWithGoogle();
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular((5)),
                          color: Colors.white,
                          boxShadow: boxShadow(
                            color: Colors.grey.withOpacity(0.7),
                            blurRadius: 1,
                            offset: const Offset(0, 1), // Shadow position
                          ),
                        ),
                        margin: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(width: 24,),
                            Image.asset(appGoogle, width: 24),
                            //Icon(FlutterRemix.google_fill,color: Color(0xFFE60023),),
                            const SizedBox(width: 20),
                            const Text("Sign in with Google",
                              style: TextStyle(
                                  color: Color(0xFF555555),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14
                              ),),
                            const SizedBox(width: 20,),
                          ],),
                      ),
                    ),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     // InkWell(
                    //     //   onTap: (){
                    //     //     controller.signInWithFacebook();
                    //     //   },
                    //     //   child: Container(
                    //     //       height: size,
                    //     //       width: size,
                    //     //       decoration: const BoxDecoration(
                    //     //         color: Color(0xFF3B5998),
                    //     //         shape: BoxShape.circle
                    //     //       ),
                    //     //       child: Center(
                    //     //         child: Icon(FlutterRemix.facebook_line,
                    //     //         color: AppColors.whiteColor(),),
                    //     //       )),
                    //     // ),
                    //     //
                    //     // 15.horizontalSpace,
                    //
                    //     // InkWell(
                    //     //   onTap: (){
                    //     //     controller.signInWithGoogle();
                    //     //   },
                    //     //   child: Container(
                    //     //       height: size,
                    //     //       width: size,
                    //     //       decoration: const BoxDecoration(
                    //     //           color: Color(0xFFE60023),
                    //     //           shape: BoxShape.circle
                    //     //       ),
                    //     //       child: Center(
                    //     //         child: Icon(FlutterRemix.google_line,
                    //     //           color: AppColors.whiteColor(),),
                    //     //       )),
                    //     // ),
                    //
                    //     // 15.horizontalSpace,
                    //     //
                    //     // Container(
                    //     //     height: size,
                    //     //     width: size,
                    //     //     decoration: const BoxDecoration(
                    //     //         color: Color(0xFF00ACEE),
                    //     //         shape: BoxShape.circle
                    //     //     ),
                    //     //     child: Center(
                    //     //       child: Icon(FlutterRemix.twitter_line,
                    //     //         color: AppColors.whiteColor(),),
                    //     //     )),
                    //     //
                    //     // 15.horizontalSpace,
                    //     //
                    //     // Container(
                    //     //     height: size,
                    //     //     width: size,
                    //     //     decoration: const BoxDecoration(
                    //     //       gradient: LinearGradient(
                    //     //         colors: [
                    //     //           Color(0xFF833AB4),
                    //     //           Color(0xFFC13584),
                    //     //           Color(0xFFE1306C),
                    //     //           Color(0xFFFF4960),
                    //     //           Color(0xFFFF512F),
                    //     //           Color(0xFFFF6B00),
                    //     //           Color(0xFFFF9500),
                    //     //           Color(0xFFFFCC00),
                    //     //         ],
                    //     //         begin: Alignment.topLeft,
                    //     //         end: Alignment.bottomRight,
                    //     //       ),
                    //     //       shape: BoxShape.circle,
                    //     //     ),
                    //     //
                    //     //     child: Center(
                    //     //       child: Icon(FlutterRemix.instagram_line,
                    //     //         color: AppColors.whiteColor(),),
                    //     //     )),
                    //   ],
                    // ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSmallScreen(BuildContext context) {
    return Stack(
      children: [

        SizedBox(
            height: Get.height,
            child: Column(
              children: [
                Image.asset(appBg2,
                    width: Get.width),
              ],
            )),

        SingleChildScrollView(
          child: GetBuilder<LoginLogic>(
            assignId: true,
            builder: (logic) {
              return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    SizedBox(height: Get.height * 0.2,),

                    Image.asset(appLogo2, width: 150.w,),

                    20.verticalSpace,

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Login",
                          style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold
                          ),),
                      ],
                    ),

                    40.verticalSpace,

                    CommonInputField(
                      hintText: 'Enter Email/Phone Number',
                      //labelText: "Email/Phone Number",
                      maxLength: 30,
                      keyboardType: TextInputType.emailAddress,
                      textController: logic.emailController,
                      suffixIcon: const Icon(Icons.email),
                    ),

                    30.verticalSpace,

                    Obx(() {
                      return CommonInputField(
                        hintText: 'Enter Password'.tr,
                        obscureText: logic.obscureText.value,
                        // labelText: "Password".tr,
                        keyboardType: TextInputType.text,
                        textController: logic.passwordController,
                        suffixIcon: IconButton(onPressed: logic.toggle,
                            icon: Icon(
                              logic.obscureText.isTrue
                                  ? Icons.visibility_off
                                  : Icons
                                  .visibility,
                            )),
                      );
                    }),

                    20.verticalSpace,

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(onPressed: () {
                          Get.toNamed(
                              rsForgotPasswordPage, arguments: {"email": logic
                              .emailController.text});
                        }, child: Text("Forgot Password".tr,
                          style: TextStyle(
                            fontSize: 14.sp,
                          ),))
                      ],
                    ),

                    2.verticalSpace,

                    Obx(() {
                      return CommonMaterialButton(text: "Login",
                          color: AppColors.primaryColor(),
                          borderRadius: 5,
                          height: 50.h,
                          fontSize: 14.sp,
                          fontColor: AppColors.whiteColor(),
                          isLoading: logic.loginProcess.value,
                          onTap: () {
                            logic.login(context: context);
                          });
                    }),

                    20.verticalSpace,

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't Have a Account".tr,
                          style: TextStyle(
                              color: AppColors.text2,
                              fontSize: 16.sp
                          ),),
                        2.horizontalSpace,
                        InkWell(
                          onTap: () {
                            Get.toNamed(rsSignUpPage);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text("SignUp",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.text2,
                                  fontSize: 15.sp
                              ),),
                          ),
                        ),
                      ],
                    ),

                    40.verticalSpace,

                    InkWell(
                      onTap: () {
                        logic.signInWithGoogle();
                      },
                      child: Container(
                        height: 50.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular((5)),
                          color: Colors.white,
                          boxShadow: boxShadow(
                            color: Colors.grey,
                            blurRadius: 1,
                            offset: const Offset(0, 2), // Shadow position
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(width: 20.w,),
                            Image.asset(appGoogle, width: 24.w),
                            //Icon(FlutterRemix.google_fill,color: Color(0xFFE60023),),
                            SizedBox(width: 25.w,),
                            Text("Sign in with Google",
                              style: TextStyle(
                                  color: const Color(0xFF555555),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp
                              ),),
                            SizedBox(width: 20.w,),
                          ],),
                      ),
                    ),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     // InkWell(
                    //     //   onTap: (){
                    //     //     controller.signInWithFacebook();
                    //     //   },
                    //     //   child: Container(
                    //     //       height: size,
                    //     //       width: size,
                    //     //       decoration: const BoxDecoration(
                    //     //         color: Color(0xFF3B5998),
                    //     //         shape: BoxShape.circle
                    //     //       ),
                    //     //       child: Center(
                    //     //         child: Icon(FlutterRemix.facebook_line,
                    //     //         color: AppColors.whiteColor(),),
                    //     //       )),
                    //     // ),
                    //     //
                    //     // 15.horizontalSpace,
                    //
                    //     // InkWell(
                    //     //   onTap: (){
                    //     //     controller.signInWithGoogle();
                    //     //   },
                    //     //   child: Container(
                    //     //       height: size,
                    //     //       width: size,
                    //     //       decoration: const BoxDecoration(
                    //     //           color: Color(0xFFE60023),
                    //     //           shape: BoxShape.circle
                    //     //       ),
                    //     //       child: Center(
                    //     //         child: Icon(FlutterRemix.google_line,
                    //     //           color: AppColors.whiteColor(),),
                    //     //       )),
                    //     // ),
                    //
                    //     // 15.horizontalSpace,
                    //     //
                    //     // Container(
                    //     //     height: size,
                    //     //     width: size,
                    //     //     decoration: const BoxDecoration(
                    //     //         color: Color(0xFF00ACEE),
                    //     //         shape: BoxShape.circle
                    //     //     ),
                    //     //     child: Center(
                    //     //       child: Icon(FlutterRemix.twitter_line,
                    //     //         color: AppColors.whiteColor(),),
                    //     //     )),
                    //     //
                    //     // 15.horizontalSpace,
                    //     //
                    //     // Container(
                    //     //     height: size,
                    //     //     width: size,
                    //     //     decoration: const BoxDecoration(
                    //     //       gradient: LinearGradient(
                    //     //         colors: [
                    //     //           Color(0xFF833AB4),
                    //     //           Color(0xFFC13584),
                    //     //           Color(0xFFE1306C),
                    //     //           Color(0xFFFF4960),
                    //     //           Color(0xFFFF512F),
                    //     //           Color(0xFFFF6B00),
                    //     //           Color(0xFFFF9500),
                    //     //           Color(0xFFFFCC00),
                    //     //         ],
                    //     //         begin: Alignment.topLeft,
                    //     //         end: Alignment.bottomRight,
                    //     //       ),
                    //     //       shape: BoxShape.circle,
                    //     //     ),
                    //     //
                    //     //     child: Center(
                    //     //       child: Icon(FlutterRemix.instagram_line,
                    //     //         color: AppColors.whiteColor(),),
                    //     //     )),
                    //   ],
                    // ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
