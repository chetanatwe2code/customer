import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/routes.dart';
import '../../theme/app_colors.dart';
import '../../utils/assets.dart';
import '../login/view.dart';
import '../widget/common_material_button.dart';
import '../widget/otp_view.dart';
import 'logic.dart';


class VerificationPage extends StatelessWidget {
  const VerificationPage({Key? key}) : super(key: key);

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


            SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: GetBuilder<VerificationLogic>(builder: (logic) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        const SizedBox(height: 150,),

                        Image.asset(appLogo2, width: 120,),

                        40.verticalSpace,

                        Row(
                          children: [
                            Text("Verify Email Address".tr,
                              style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold
                              ),),
                          ],
                        ),

                        5.verticalSpace,

                        if(logic.argumentData?['email'] != null)
                          Row(
                            children: [
                              Flexible(
                                child: Text("We have sent".trParams({
                                  "email" : logic.argumentData?['email']
                                }),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300
                                  ),),
                              ),
                            ],
                          ),

                        50.verticalSpace,

                        /// OTP VIEW
                        // SizedBox(
                        //   height: 80,
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Container(
                        //         height: 44,
                        //         width: 44,
                        //         decoration: BoxDecoration(
                        //           border: Border(bottom: BorderSide(
                        //               color: AppColors.grayColor(), width: 0.7)),
                        //         ),
                        //         alignment: Alignment.center,
                        //         child: ClipPath(
                        //           clipper: ShapeBorderClipper(
                        //               shape: RoundedRectangleBorder(
                        //                   borderRadius: BorderRadius.circular(4))),
                        //           child: TextField(
                        //             maxLines: 1,
                        //             maxLength: 1,
                        //             controller: logic.otp1Controller,
                        //             focusNode: logic.focusNode1,
                        //             keyboardType: TextInputType.number,
                        //             textAlign: TextAlign.center,
                        //             textInputAction: TextInputAction.next,
                        //             onSubmitted: (String? s) {
                        //               if (s?.isEmpty ?? false) {
                        //                 logic.focusNode1.unfocus();
                        //               }
                        //             },
                        //             onChanged: (otp) {
                        //               if (logic.removeAndAdd(1, otp)) {
                        //                 FocusScope.of(context).requestFocus(
                        //                     logic.focusNode2);
                        //               }
                        //             },
                        //             decoration: InputDecoration(
                        //               hintText: "0",
                        //               contentPadding: EdgeInsets.zero,
                        //               border: InputBorder.none,
                        //               focusedBorder: InputBorder.none,
                        //               counter: const Offstage(),
                        //               hintStyle: TextStyle(
                        //                   fontWeight: FontWeight.normal,
                        //                   fontSize: 12,
                        //                   color: AppColors.grayColor().withOpacity(
                        //                       0.5)
                        //               ),
                        //               errorStyle: const TextStyle(height: 1.5),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //
                        //       Container(
                        //         height: 44,
                        //         width: 44,
                        //         decoration: BoxDecoration(
                        //           border: Border(bottom: BorderSide(
                        //               color: AppColors.grayColor(), width: 0.7)),
                        //         ),
                        //         alignment: Alignment.center,
                        //         child: ClipPath(
                        //           clipper: ShapeBorderClipper(
                        //               shape: RoundedRectangleBorder(
                        //                   borderRadius: BorderRadius.circular(4))),
                        //           child: TextField(
                        //             maxLines: 1,
                        //             maxLength: 1,
                        //             focusNode: logic.focusNode2,
                        //             controller: logic.otp2Controller,
                        //             keyboardType: TextInputType.number,
                        //             textAlign: TextAlign.center,
                        //             textInputAction: TextInputAction.next,
                        //             onSubmitted: (String? s) {
                        //               if (s?.isEmpty ?? false) {
                        //                 logic.focusNode2.unfocus();
                        //               }
                        //             },
                        //             onChanged: (otp) {
                        //               if (logic.removeAndAdd(2, otp)) {
                        //                 FocusScope.of(context).requestFocus(
                        //                     logic.focusNode3);
                        //               }
                        //               else {
                        //                 FocusScope.of(context).requestFocus(
                        //                     logic.focusNode1);
                        //               }
                        //             },
                        //             decoration: InputDecoration(
                        //               hintText: "0",
                        //               contentPadding: EdgeInsets.zero,
                        //               border: InputBorder.none,
                        //               focusedBorder: InputBorder.none,
                        //               counter: const Offstage(),
                        //               hintStyle: TextStyle(
                        //                   fontWeight: FontWeight.normal,
                        //                   fontSize: 12,
                        //                   color: AppColors.grayColor().withOpacity(
                        //                       0.5)
                        //               ),
                        //               errorStyle: const TextStyle(height: 1.5),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //
                        //       Container(
                        //         height: 44,
                        //         width: 44,
                        //         decoration: BoxDecoration(
                        //           border: Border(bottom: BorderSide(
                        //               color: AppColors.grayColor(), width: 0.7)),
                        //         ),
                        //         alignment: Alignment.center,
                        //         child: ClipPath(
                        //           clipper: ShapeBorderClipper(
                        //               shape: RoundedRectangleBorder(
                        //                   borderRadius: BorderRadius.circular(4))),
                        //           child: TextField(
                        //             maxLines: 1,
                        //             maxLength: 1,
                        //             controller: logic.otp3Controller,
                        //             keyboardType: TextInputType.number,
                        //             textAlign: TextAlign.center,
                        //             textInputAction: TextInputAction.next,
                        //             focusNode: logic.focusNode3,
                        //             onSubmitted: (String? s) {
                        //               if (s?.isEmpty ?? false) {
                        //                 logic.focusNode3.unfocus();
                        //               }
                        //             },
                        //             onChanged: (otp) {
                        //               if (logic.removeAndAdd(2, otp)) {
                        //                 FocusScope.of(context).requestFocus(
                        //                     logic.focusNode4);
                        //               }
                        //               else {
                        //                 FocusScope.of(context).requestFocus(
                        //                     logic.focusNode2);
                        //               }
                        //             },
                        //             decoration: InputDecoration(
                        //               hintText: "0",
                        //               contentPadding: EdgeInsets.zero,
                        //               border: InputBorder.none,
                        //               focusedBorder: InputBorder.none,
                        //               counter: const Offstage(),
                        //               hintStyle: TextStyle(
                        //                   fontWeight: FontWeight.normal,
                        //                   fontSize: 12,
                        //                   color: AppColors.grayColor().withOpacity(
                        //                       0.5)
                        //               ),
                        //               errorStyle: const TextStyle(height: 1.5),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //
                        //       Container(
                        //         height: 44,
                        //         width: 44,
                        //         decoration: BoxDecoration(
                        //           border: Border(bottom: BorderSide(
                        //               color: AppColors.grayColor(), width: 0.7)),
                        //         ),
                        //         alignment: Alignment.center,
                        //         child: ClipPath(
                        //           clipper: ShapeBorderClipper(
                        //               shape: RoundedRectangleBorder(
                        //                   borderRadius: BorderRadius.circular(4))),
                        //           child: TextField(
                        //             maxLines: 1,
                        //             maxLength: 1,
                        //             controller: logic.otp4Controller,
                        //             keyboardType: TextInputType.number,
                        //             textAlign: TextAlign.center,
                        //             textInputAction: TextInputAction.next,
                        //             focusNode: logic.focusNode4,
                        //             onSubmitted: (String? s) {
                        //               if (s?.isEmpty ?? false) {
                        //                 logic.focusNode4.unfocus();
                        //               }
                        //             },
                        //             onChanged: (otp) {
                        //               if (logic.removeAndAdd(2, otp)) {
                        //                 FocusScope.of(context).requestFocus(
                        //                     logic.focusNode5);
                        //               }
                        //               else {
                        //                 FocusScope.of(context).requestFocus(
                        //                     logic.focusNode3);
                        //               }
                        //             },
                        //             decoration: InputDecoration(
                        //               hintText: "0",
                        //               contentPadding: EdgeInsets.zero,
                        //               border: InputBorder.none,
                        //               focusedBorder: InputBorder.none,
                        //               counter: const Offstage(),
                        //               hintStyle: TextStyle(
                        //                   fontWeight: FontWeight.normal,
                        //                   fontSize: 12,
                        //                   color: AppColors.grayColor().withOpacity(
                        //                       0.5)
                        //               ),
                        //               errorStyle: const TextStyle(height: 1.5),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //
                        //       Container(
                        //         height: 44,
                        //         width: 44,
                        //         decoration: BoxDecoration(
                        //           border: Border(bottom: BorderSide(
                        //               color: AppColors.grayColor(), width: 0.7)),
                        //         ),
                        //         alignment: Alignment.center,
                        //         child: ClipPath(
                        //           clipper: ShapeBorderClipper(
                        //               shape: RoundedRectangleBorder(
                        //                   borderRadius: BorderRadius.circular(4))),
                        //           child: TextField(
                        //             maxLines: 1,
                        //             maxLength: 1,
                        //             controller: logic.otp5Controller,
                        //             keyboardType: TextInputType.number,
                        //             textAlign: TextAlign.center,
                        //             textInputAction: TextInputAction.next,
                        //             focusNode: logic.focusNode5,
                        //             onSubmitted: (String? s) {
                        //               if (s?.isEmpty ?? false) {
                        //                 logic.focusNode5.unfocus();
                        //               }
                        //             },
                        //             onChanged: (otp) {
                        //               if (logic.removeAndAdd(4, otp)) {
                        //                 FocusScope.of(context).requestFocus(
                        //                     logic.focusNode6);
                        //               }
                        //               else {
                        //                 FocusScope.of(context).requestFocus(
                        //                     logic.focusNode4);
                        //               }
                        //             },
                        //             decoration: InputDecoration(
                        //               hintText: "0",
                        //               contentPadding: EdgeInsets.zero,
                        //               border: InputBorder.none,
                        //               focusedBorder: InputBorder.none,
                        //               counter: const Offstage(),
                        //               hintStyle: TextStyle(
                        //                   fontWeight: FontWeight.normal,
                        //                   fontSize: 12,
                        //                   color: AppColors.grayColor().withOpacity(
                        //                       0.5)
                        //               ),
                        //               errorStyle: const TextStyle(height: 1.5),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //       //
                        //       Container(
                        //         height: 44,
                        //         width: 44,
                        //         decoration: BoxDecoration(
                        //           border: Border(bottom: BorderSide(
                        //               color: AppColors.grayColor(), width: 0.7)),
                        //         ),
                        //         alignment: Alignment.center,
                        //         child: ClipPath(
                        //           clipper: ShapeBorderClipper(
                        //               shape: RoundedRectangleBorder(
                        //                   borderRadius: BorderRadius.circular(4))),
                        //           child: TextField(
                        //             maxLines: 1,
                        //             maxLength: 1,
                        //             focusNode: logic.focusNode6,
                        //             controller: logic.otp6Controller,
                        //             keyboardType: TextInputType.number,
                        //             textAlign: TextAlign.center,
                        //             textInputAction: TextInputAction.next,
                        //             onChanged: (otp) {
                        //               if (logic.removeAndAdd(5, otp)) {
                        //                 logic.focusNode6.unfocus();
                        //               }
                        //               else {
                        //                 FocusScope.of(context).requestFocus(
                        //                     logic.focusNode5);
                        //               }
                        //             },
                        //             decoration: InputDecoration(
                        //               hintText: "0",
                        //               contentPadding: EdgeInsets.zero,
                        //               border: InputBorder.none,
                        //               focusedBorder: InputBorder.none,
                        //               counter: const Offstage(),
                        //               hintStyle: TextStyle(
                        //                   fontWeight: FontWeight.normal,
                        //                   fontSize: 12,
                        //                   color: AppColors.grayColor().withOpacity(
                        //                       0.5)
                        //               ),
                        //               errorStyle: const TextStyle(height: 1.5),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //
                        //     ],
                        //   ),
                        // ),


                        OtpView(
                          key: logic.otpKey,
                          otpCallBack: (s){
                            logic.otpString = s;
                          },
                        ),
                        /// END
                        Obx(() {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [

                             if(logic.time.value > 0)
                              Text(logic.getTime(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold
                                ),),

                              TextButton(onPressed: (logic.resentOtpProgress.value ||
                                  logic.time.value > 0)
                                  ? null
                                  : () {
                                logic.resentOtp();
                              }, child: Text("Resend OTP".tr)),

                              if(logic.resentOtpProgress.value)
                                const SizedBox(
                                  height: 15,
                                  width: 15,
                                  child: CircularProgressIndicator(strokeWidth: 2,),
                                ),
                            ],
                          );
                        }),

                        50.verticalSpace,


                        CommonMaterialButton(text: "Verify-OTP".tr,
                            color: AppColors.primaryColor(),
                            borderRadius: 5,
                            fontColor: AppColors.whiteColor(),
                            isLoading: logic.verifyProcess.value,
                            onTap: () {
                              logic.verifyEmail(context);
                            }),

                        const SizedBox(height: 30,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Go to login".tr,
                              style: const TextStyle(
                                  color: AppColors.text2,
                                  fontSize: 16
                              ),),

                            InkWell(
                              onTap: (){
                                Get.offNamed(rsLoginPage);
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text("Login",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.text2,
                                      fontSize: 15
                                  ),),
                              ),
                            ),
                          ],
                        ),

                      ],
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
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


        SafeArea(
          child: SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: GetBuilder<VerificationLogic>(builder: (logic) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    const SizedBox(height: 150,),

                    Image.asset(appLogo2, width: 120,),

                    40.verticalSpace,

                    Row(
                      children: [
                        Text("Verify Email Address".tr,
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold
                          ),),
                      ],
                    ),

                    5.verticalSpace,

                    if(logic.argumentData?['email'] != null)
                      Row(
                        children: [
                          Flexible(
                            child: Text("We have sent".trParams({
                              "email" : logic.argumentData?['email']
                            }),
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300
                              ),),
                          ),
                        ],
                      ),

                    50.verticalSpace,

                    /// OTP VIEW
                    // SizedBox(
                    //   height: 80,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Container(
                    //         height: 44,
                    //         width: 44,
                    //         decoration: BoxDecoration(
                    //           border: Border(bottom: BorderSide(
                    //               color: AppColors.grayColor(), width: 0.7)),
                    //         ),
                    //         alignment: Alignment.center,
                    //         child: ClipPath(
                    //           clipper: ShapeBorderClipper(
                    //               shape: RoundedRectangleBorder(
                    //                   borderRadius: BorderRadius.circular(4))),
                    //           child: TextField(
                    //             maxLines: 1,
                    //             maxLength: 1,
                    //             controller: logic.otp1Controller,
                    //             focusNode: logic.focusNode1,
                    //             keyboardType: TextInputType.number,
                    //             textAlign: TextAlign.center,
                    //             textInputAction: TextInputAction.next,
                    //             onSubmitted: (String? s) {
                    //               if (s?.isEmpty ?? false) {
                    //                 logic.focusNode1.unfocus();
                    //               }
                    //             },
                    //             onChanged: (otp) {
                    //               if (logic.removeAndAdd(1, otp)) {
                    //                 FocusScope.of(context).requestFocus(
                    //                     logic.focusNode2);
                    //               }
                    //             },
                    //             decoration: InputDecoration(
                    //               hintText: "0",
                    //               contentPadding: EdgeInsets.zero,
                    //               border: InputBorder.none,
                    //               focusedBorder: InputBorder.none,
                    //               counter: const Offstage(),
                    //               hintStyle: TextStyle(
                    //                   fontWeight: FontWeight.normal,
                    //                   fontSize: 12,
                    //                   color: AppColors.grayColor().withOpacity(
                    //                       0.5)
                    //               ),
                    //               errorStyle: const TextStyle(height: 1.5),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //
                    //       Container(
                    //         height: 44,
                    //         width: 44,
                    //         decoration: BoxDecoration(
                    //           border: Border(bottom: BorderSide(
                    //               color: AppColors.grayColor(), width: 0.7)),
                    //         ),
                    //         alignment: Alignment.center,
                    //         child: ClipPath(
                    //           clipper: ShapeBorderClipper(
                    //               shape: RoundedRectangleBorder(
                    //                   borderRadius: BorderRadius.circular(4))),
                    //           child: TextField(
                    //             maxLines: 1,
                    //             maxLength: 1,
                    //             focusNode: logic.focusNode2,
                    //             controller: logic.otp2Controller,
                    //             keyboardType: TextInputType.number,
                    //             textAlign: TextAlign.center,
                    //             textInputAction: TextInputAction.next,
                    //             onSubmitted: (String? s) {
                    //               if (s?.isEmpty ?? false) {
                    //                 logic.focusNode2.unfocus();
                    //               }
                    //             },
                    //             onChanged: (otp) {
                    //               if (logic.removeAndAdd(2, otp)) {
                    //                 FocusScope.of(context).requestFocus(
                    //                     logic.focusNode3);
                    //               }
                    //               else {
                    //                 FocusScope.of(context).requestFocus(
                    //                     logic.focusNode1);
                    //               }
                    //             },
                    //             decoration: InputDecoration(
                    //               hintText: "0",
                    //               contentPadding: EdgeInsets.zero,
                    //               border: InputBorder.none,
                    //               focusedBorder: InputBorder.none,
                    //               counter: const Offstage(),
                    //               hintStyle: TextStyle(
                    //                   fontWeight: FontWeight.normal,
                    //                   fontSize: 12,
                    //                   color: AppColors.grayColor().withOpacity(
                    //                       0.5)
                    //               ),
                    //               errorStyle: const TextStyle(height: 1.5),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //
                    //       Container(
                    //         height: 44,
                    //         width: 44,
                    //         decoration: BoxDecoration(
                    //           border: Border(bottom: BorderSide(
                    //               color: AppColors.grayColor(), width: 0.7)),
                    //         ),
                    //         alignment: Alignment.center,
                    //         child: ClipPath(
                    //           clipper: ShapeBorderClipper(
                    //               shape: RoundedRectangleBorder(
                    //                   borderRadius: BorderRadius.circular(4))),
                    //           child: TextField(
                    //             maxLines: 1,
                    //             maxLength: 1,
                    //             controller: logic.otp3Controller,
                    //             keyboardType: TextInputType.number,
                    //             textAlign: TextAlign.center,
                    //             textInputAction: TextInputAction.next,
                    //             focusNode: logic.focusNode3,
                    //             onSubmitted: (String? s) {
                    //               if (s?.isEmpty ?? false) {
                    //                 logic.focusNode3.unfocus();
                    //               }
                    //             },
                    //             onChanged: (otp) {
                    //               if (logic.removeAndAdd(2, otp)) {
                    //                 FocusScope.of(context).requestFocus(
                    //                     logic.focusNode4);
                    //               }
                    //               else {
                    //                 FocusScope.of(context).requestFocus(
                    //                     logic.focusNode2);
                    //               }
                    //             },
                    //             decoration: InputDecoration(
                    //               hintText: "0",
                    //               contentPadding: EdgeInsets.zero,
                    //               border: InputBorder.none,
                    //               focusedBorder: InputBorder.none,
                    //               counter: const Offstage(),
                    //               hintStyle: TextStyle(
                    //                   fontWeight: FontWeight.normal,
                    //                   fontSize: 12,
                    //                   color: AppColors.grayColor().withOpacity(
                    //                       0.5)
                    //               ),
                    //               errorStyle: const TextStyle(height: 1.5),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //
                    //       Container(
                    //         height: 44,
                    //         width: 44,
                    //         decoration: BoxDecoration(
                    //           border: Border(bottom: BorderSide(
                    //               color: AppColors.grayColor(), width: 0.7)),
                    //         ),
                    //         alignment: Alignment.center,
                    //         child: ClipPath(
                    //           clipper: ShapeBorderClipper(
                    //               shape: RoundedRectangleBorder(
                    //                   borderRadius: BorderRadius.circular(4))),
                    //           child: TextField(
                    //             maxLines: 1,
                    //             maxLength: 1,
                    //             controller: logic.otp4Controller,
                    //             keyboardType: TextInputType.number,
                    //             textAlign: TextAlign.center,
                    //             textInputAction: TextInputAction.next,
                    //             focusNode: logic.focusNode4,
                    //             onSubmitted: (String? s) {
                    //               if (s?.isEmpty ?? false) {
                    //                 logic.focusNode4.unfocus();
                    //               }
                    //             },
                    //             onChanged: (otp) {
                    //               if (logic.removeAndAdd(2, otp)) {
                    //                 FocusScope.of(context).requestFocus(
                    //                     logic.focusNode5);
                    //               }
                    //               else {
                    //                 FocusScope.of(context).requestFocus(
                    //                     logic.focusNode3);
                    //               }
                    //             },
                    //             decoration: InputDecoration(
                    //               hintText: "0",
                    //               contentPadding: EdgeInsets.zero,
                    //               border: InputBorder.none,
                    //               focusedBorder: InputBorder.none,
                    //               counter: const Offstage(),
                    //               hintStyle: TextStyle(
                    //                   fontWeight: FontWeight.normal,
                    //                   fontSize: 12,
                    //                   color: AppColors.grayColor().withOpacity(
                    //                       0.5)
                    //               ),
                    //               errorStyle: const TextStyle(height: 1.5),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //
                    //       Container(
                    //         height: 44,
                    //         width: 44,
                    //         decoration: BoxDecoration(
                    //           border: Border(bottom: BorderSide(
                    //               color: AppColors.grayColor(), width: 0.7)),
                    //         ),
                    //         alignment: Alignment.center,
                    //         child: ClipPath(
                    //           clipper: ShapeBorderClipper(
                    //               shape: RoundedRectangleBorder(
                    //                   borderRadius: BorderRadius.circular(4))),
                    //           child: TextField(
                    //             maxLines: 1,
                    //             maxLength: 1,
                    //             controller: logic.otp5Controller,
                    //             keyboardType: TextInputType.number,
                    //             textAlign: TextAlign.center,
                    //             textInputAction: TextInputAction.next,
                    //             focusNode: logic.focusNode5,
                    //             onSubmitted: (String? s) {
                    //               if (s?.isEmpty ?? false) {
                    //                 logic.focusNode5.unfocus();
                    //               }
                    //             },
                    //             onChanged: (otp) {
                    //               if (logic.removeAndAdd(4, otp)) {
                    //                 FocusScope.of(context).requestFocus(
                    //                     logic.focusNode6);
                    //               }
                    //               else {
                    //                 FocusScope.of(context).requestFocus(
                    //                     logic.focusNode4);
                    //               }
                    //             },
                    //             decoration: InputDecoration(
                    //               hintText: "0",
                    //               contentPadding: EdgeInsets.zero,
                    //               border: InputBorder.none,
                    //               focusedBorder: InputBorder.none,
                    //               counter: const Offstage(),
                    //               hintStyle: TextStyle(
                    //                   fontWeight: FontWeight.normal,
                    //                   fontSize: 12,
                    //                   color: AppColors.grayColor().withOpacity(
                    //                       0.5)
                    //               ),
                    //               errorStyle: const TextStyle(height: 1.5),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       //
                    //       Container(
                    //         height: 44,
                    //         width: 44,
                    //         decoration: BoxDecoration(
                    //           border: Border(bottom: BorderSide(
                    //               color: AppColors.grayColor(), width: 0.7)),
                    //         ),
                    //         alignment: Alignment.center,
                    //         child: ClipPath(
                    //           clipper: ShapeBorderClipper(
                    //               shape: RoundedRectangleBorder(
                    //                   borderRadius: BorderRadius.circular(4))),
                    //           child: TextField(
                    //             maxLines: 1,
                    //             maxLength: 1,
                    //             focusNode: logic.focusNode6,
                    //             controller: logic.otp6Controller,
                    //             keyboardType: TextInputType.number,
                    //             textAlign: TextAlign.center,
                    //             textInputAction: TextInputAction.next,
                    //             onChanged: (otp) {
                    //               if (logic.removeAndAdd(5, otp)) {
                    //                 logic.focusNode6.unfocus();
                    //               }
                    //               else {
                    //                 FocusScope.of(context).requestFocus(
                    //                     logic.focusNode5);
                    //               }
                    //             },
                    //             decoration: InputDecoration(
                    //               hintText: "0",
                    //               contentPadding: EdgeInsets.zero,
                    //               border: InputBorder.none,
                    //               focusedBorder: InputBorder.none,
                    //               counter: const Offstage(),
                    //               hintStyle: TextStyle(
                    //                   fontWeight: FontWeight.normal,
                    //                   fontSize: 12,
                    //                   color: AppColors.grayColor().withOpacity(
                    //                       0.5)
                    //               ),
                    //               errorStyle: const TextStyle(height: 1.5),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //
                    //     ],
                    //   ),
                    // ),


                    OtpView(
                      key: logic.otpKey,
                      otpCallBack: (s){
                        logic.otpString = s;
                      },
                    ),
                    /// END
                    Obx(() {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                          if(logic.time.value > 0)
                            Text(logic.getTime(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold
                              ),),

                          TextButton(onPressed: (logic.resentOtpProgress.value ||
                              logic.time.value > 0)
                              ? null
                              : () {
                            logic.resentOtp();
                          }, child: Text("Resend OTP".tr)),

                          if(logic.resentOtpProgress.value)
                            const SizedBox(
                              height: 15,
                              width: 15,
                              child: CircularProgressIndicator(strokeWidth: 2,),
                            ),
                        ],
                      );
                    }),

                    50.verticalSpace,


                    CommonMaterialButton(text: "Verify-OTP".tr,
                        color: AppColors.primaryColor(),
                        borderRadius: 5,
                        fontColor: AppColors.whiteColor(),
                        isLoading: logic.verifyProcess.value,
                        onTap: () {
                          logic.verifyEmail(context);
                        }),

                    const SizedBox(height: 30,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Go to login".tr,
                          style: const TextStyle(
                              color: AppColors.text2,
                              fontSize: 16
                          ),),

                        InkWell(
                          onTap: (){
                            Get.offNamed(rsLoginPage);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text("Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.text2,
                                  fontSize: 15
                              ),),
                          ),
                        ),
                      ],
                    ),

                  ],
                );
              }),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLargeScreen(BuildContext context,Size media){
    double width = getScreenPadding(media);
    return Stack(
      children: [

        Image.asset(appBg2,
            width: Get.width,fit: BoxFit.fitWidth,),


        SafeArea(
          child: SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: width),
              child: GetBuilder<VerificationLogic>(builder: (logic) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    SizedBox(height: Get.height * 0.35,),

                    Row(
                      children: [
                        Text("Verify Email Address".tr,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                          ),),
                      ],
                    ),

                    5.verticalSpace,

                   // if(logic.argumentData?['email'] != null)
                      Row(
                        children: [
                          Flexible(
                            child: Text("We have sent".trParams({
                              "email" : logic.argumentData?['email'] ?? ""
                            }),
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300
                              ),),
                          ),
                        ],
                      ),

                    50.verticalSpace,

                    /// OTP VIEW
                    // SizedBox(
                    //   height: 80,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Container(
                    //         height: 44,
                    //         width: 44,
                    //         decoration: BoxDecoration(
                    //           border: Border(bottom: BorderSide(
                    //               color: AppColors.grayColor(), width: 0.7)),
                    //         ),
                    //         alignment: Alignment.center,
                    //         child: ClipPath(
                    //           clipper: ShapeBorderClipper(
                    //               shape: RoundedRectangleBorder(
                    //                   borderRadius: BorderRadius.circular(4))),
                    //           child: TextField(
                    //             maxLines: 1,
                    //             maxLength: 1,
                    //             controller: logic.otp1Controller,
                    //             focusNode: logic.focusNode1,
                    //             keyboardType: TextInputType.number,
                    //             textAlign: TextAlign.center,
                    //             textInputAction: TextInputAction.next,
                    //             onSubmitted: (String? s) {
                    //               if (s?.isEmpty ?? false) {
                    //                 logic.focusNode1.unfocus();
                    //               }
                    //             },
                    //             onChanged: (otp) {
                    //               if (logic.removeAndAdd(1, otp)) {
                    //                 FocusScope.of(context).requestFocus(
                    //                     logic.focusNode2);
                    //               }
                    //             },
                    //             decoration: InputDecoration(
                    //               hintText: "0",
                    //               contentPadding: EdgeInsets.zero,
                    //               border: InputBorder.none,
                    //               focusedBorder: InputBorder.none,
                    //               counter: const Offstage(),
                    //               hintStyle: TextStyle(
                    //                   fontWeight: FontWeight.normal,
                    //                   fontSize: 12,
                    //                   color: AppColors.grayColor().withOpacity(
                    //                       0.5)
                    //               ),
                    //               errorStyle: const TextStyle(height: 1.5),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //
                    //       Container(
                    //         height: 44,
                    //         width: 44,
                    //         decoration: BoxDecoration(
                    //           border: Border(bottom: BorderSide(
                    //               color: AppColors.grayColor(), width: 0.7)),
                    //         ),
                    //         alignment: Alignment.center,
                    //         child: ClipPath(
                    //           clipper: ShapeBorderClipper(
                    //               shape: RoundedRectangleBorder(
                    //                   borderRadius: BorderRadius.circular(4))),
                    //           child: TextField(
                    //             maxLines: 1,
                    //             maxLength: 1,
                    //             focusNode: logic.focusNode2,
                    //             controller: logic.otp2Controller,
                    //             keyboardType: TextInputType.number,
                    //             textAlign: TextAlign.center,
                    //             textInputAction: TextInputAction.next,
                    //             onSubmitted: (String? s) {
                    //               if (s?.isEmpty ?? false) {
                    //                 logic.focusNode2.unfocus();
                    //               }
                    //             },
                    //             onChanged: (otp) {
                    //               if (logic.removeAndAdd(2, otp)) {
                    //                 FocusScope.of(context).requestFocus(
                    //                     logic.focusNode3);
                    //               }
                    //               else {
                    //                 FocusScope.of(context).requestFocus(
                    //                     logic.focusNode1);
                    //               }
                    //             },
                    //             decoration: InputDecoration(
                    //               hintText: "0",
                    //               contentPadding: EdgeInsets.zero,
                    //               border: InputBorder.none,
                    //               focusedBorder: InputBorder.none,
                    //               counter: const Offstage(),
                    //               hintStyle: TextStyle(
                    //                   fontWeight: FontWeight.normal,
                    //                   fontSize: 12,
                    //                   color: AppColors.grayColor().withOpacity(
                    //                       0.5)
                    //               ),
                    //               errorStyle: const TextStyle(height: 1.5),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //
                    //       Container(
                    //         height: 44,
                    //         width: 44,
                    //         decoration: BoxDecoration(
                    //           border: Border(bottom: BorderSide(
                    //               color: AppColors.grayColor(), width: 0.7)),
                    //         ),
                    //         alignment: Alignment.center,
                    //         child: ClipPath(
                    //           clipper: ShapeBorderClipper(
                    //               shape: RoundedRectangleBorder(
                    //                   borderRadius: BorderRadius.circular(4))),
                    //           child: TextField(
                    //             maxLines: 1,
                    //             maxLength: 1,
                    //             controller: logic.otp3Controller,
                    //             keyboardType: TextInputType.number,
                    //             textAlign: TextAlign.center,
                    //             textInputAction: TextInputAction.next,
                    //             focusNode: logic.focusNode3,
                    //             onSubmitted: (String? s) {
                    //               if (s?.isEmpty ?? false) {
                    //                 logic.focusNode3.unfocus();
                    //               }
                    //             },
                    //             onChanged: (otp) {
                    //               if (logic.removeAndAdd(2, otp)) {
                    //                 FocusScope.of(context).requestFocus(
                    //                     logic.focusNode4);
                    //               }
                    //               else {
                    //                 FocusScope.of(context).requestFocus(
                    //                     logic.focusNode2);
                    //               }
                    //             },
                    //             decoration: InputDecoration(
                    //               hintText: "0",
                    //               contentPadding: EdgeInsets.zero,
                    //               border: InputBorder.none,
                    //               focusedBorder: InputBorder.none,
                    //               counter: const Offstage(),
                    //               hintStyle: TextStyle(
                    //                   fontWeight: FontWeight.normal,
                    //                   fontSize: 12,
                    //                   color: AppColors.grayColor().withOpacity(
                    //                       0.5)
                    //               ),
                    //               errorStyle: const TextStyle(height: 1.5),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //
                    //       Container(
                    //         height: 44,
                    //         width: 44,
                    //         decoration: BoxDecoration(
                    //           border: Border(bottom: BorderSide(
                    //               color: AppColors.grayColor(), width: 0.7)),
                    //         ),
                    //         alignment: Alignment.center,
                    //         child: ClipPath(
                    //           clipper: ShapeBorderClipper(
                    //               shape: RoundedRectangleBorder(
                    //                   borderRadius: BorderRadius.circular(4))),
                    //           child: TextField(
                    //             maxLines: 1,
                    //             maxLength: 1,
                    //             controller: logic.otp4Controller,
                    //             keyboardType: TextInputType.number,
                    //             textAlign: TextAlign.center,
                    //             textInputAction: TextInputAction.next,
                    //             focusNode: logic.focusNode4,
                    //             onSubmitted: (String? s) {
                    //               if (s?.isEmpty ?? false) {
                    //                 logic.focusNode4.unfocus();
                    //               }
                    //             },
                    //             onChanged: (otp) {
                    //               if (logic.removeAndAdd(2, otp)) {
                    //                 FocusScope.of(context).requestFocus(
                    //                     logic.focusNode5);
                    //               }
                    //               else {
                    //                 FocusScope.of(context).requestFocus(
                    //                     logic.focusNode3);
                    //               }
                    //             },
                    //             decoration: InputDecoration(
                    //               hintText: "0",
                    //               contentPadding: EdgeInsets.zero,
                    //               border: InputBorder.none,
                    //               focusedBorder: InputBorder.none,
                    //               counter: const Offstage(),
                    //               hintStyle: TextStyle(
                    //                   fontWeight: FontWeight.normal,
                    //                   fontSize: 12,
                    //                   color: AppColors.grayColor().withOpacity(
                    //                       0.5)
                    //               ),
                    //               errorStyle: const TextStyle(height: 1.5),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //
                    //       Container(
                    //         height: 44,
                    //         width: 44,
                    //         decoration: BoxDecoration(
                    //           border: Border(bottom: BorderSide(
                    //               color: AppColors.grayColor(), width: 0.7)),
                    //         ),
                    //         alignment: Alignment.center,
                    //         child: ClipPath(
                    //           clipper: ShapeBorderClipper(
                    //               shape: RoundedRectangleBorder(
                    //                   borderRadius: BorderRadius.circular(4))),
                    //           child: TextField(
                    //             maxLines: 1,
                    //             maxLength: 1,
                    //             controller: logic.otp5Controller,
                    //             keyboardType: TextInputType.number,
                    //             textAlign: TextAlign.center,
                    //             textInputAction: TextInputAction.next,
                    //             focusNode: logic.focusNode5,
                    //             onSubmitted: (String? s) {
                    //               if (s?.isEmpty ?? false) {
                    //                 logic.focusNode5.unfocus();
                    //               }
                    //             },
                    //             onChanged: (otp) {
                    //               if (logic.removeAndAdd(4, otp)) {
                    //                 FocusScope.of(context).requestFocus(
                    //                     logic.focusNode6);
                    //               }
                    //               else {
                    //                 FocusScope.of(context).requestFocus(
                    //                     logic.focusNode4);
                    //               }
                    //             },
                    //             decoration: InputDecoration(
                    //               hintText: "0",
                    //               contentPadding: EdgeInsets.zero,
                    //               border: InputBorder.none,
                    //               focusedBorder: InputBorder.none,
                    //               counter: const Offstage(),
                    //               hintStyle: TextStyle(
                    //                   fontWeight: FontWeight.normal,
                    //                   fontSize: 12,
                    //                   color: AppColors.grayColor().withOpacity(
                    //                       0.5)
                    //               ),
                    //               errorStyle: const TextStyle(height: 1.5),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       //
                    //       Container(
                    //         height: 44,
                    //         width: 44,
                    //         decoration: BoxDecoration(
                    //           border: Border(bottom: BorderSide(
                    //               color: AppColors.grayColor(), width: 0.7)),
                    //         ),
                    //         alignment: Alignment.center,
                    //         child: ClipPath(
                    //           clipper: ShapeBorderClipper(
                    //               shape: RoundedRectangleBorder(
                    //                   borderRadius: BorderRadius.circular(4))),
                    //           child: TextField(
                    //             maxLines: 1,
                    //             maxLength: 1,
                    //             focusNode: logic.focusNode6,
                    //             controller: logic.otp6Controller,
                    //             keyboardType: TextInputType.number,
                    //             textAlign: TextAlign.center,
                    //             textInputAction: TextInputAction.next,
                    //             onChanged: (otp) {
                    //               if (logic.removeAndAdd(5, otp)) {
                    //                 logic.focusNode6.unfocus();
                    //               }
                    //               else {
                    //                 FocusScope.of(context).requestFocus(
                    //                     logic.focusNode5);
                    //               }
                    //             },
                    //             decoration: InputDecoration(
                    //               hintText: "0",
                    //               contentPadding: EdgeInsets.zero,
                    //               border: InputBorder.none,
                    //               focusedBorder: InputBorder.none,
                    //               counter: const Offstage(),
                    //               hintStyle: TextStyle(
                    //                   fontWeight: FontWeight.normal,
                    //                   fontSize: 12,
                    //                   color: AppColors.grayColor().withOpacity(
                    //                       0.5)
                    //               ),
                    //               errorStyle: const TextStyle(height: 1.5),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //
                    //     ],
                    //   ),
                    // ),


                    OtpView(
                      key: logic.otpKey,
                      otpCallBack: (s){
                        logic.otpString = s;
                      },
                    ),
                    /// END
                    Obx(() {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                          if(logic.time.value > 0)
                            Text(logic.getTime(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold
                              ),),

                          TextButton(onPressed: (logic.resentOtpProgress.value ||
                              logic.time.value > 0)
                              ? null
                              : () {
                            logic.resentOtp();
                          }, child: Text("Resend OTP".tr,
                            style: const TextStyle(
                                fontSize: 14
                            ),),
                           ),

                          if(logic.resentOtpProgress.value)
                            const SizedBox(
                              height: 14,
                              width: 14,
                              child: CircularProgressIndicator(strokeWidth: 2,),
                            ),
                        ],
                      );
                    }),

                    50.verticalSpace,


                    CommonMaterialButton(text: "Verify-OTP".tr,
                        color: AppColors.primaryColor(),
                        borderRadius: 5,
                        fontSize: 24,
                        height: 50,
                        fontColor: AppColors.whiteColor(),
                        isLoading: logic.verifyProcess.value,
                        onTap: () {
                          logic.verifyEmail(context);
                        }),

                    const SizedBox(height: 30,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Go to login".tr,
                          style: const TextStyle(
                              color: AppColors.text2,
                              fontSize: 14
                          ),),

                        InkWell(
                          onTap: (){
                            Get.offNamed(rsLoginPage);
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
                );
              }),
            ),
          ),
        ),
      ],
    );
  }

}
