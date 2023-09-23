import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:indiakinursery/utils/string_extensions.dart';
import 'package:indiakinursery/view/account/widget/profile_menu_item.dart';
import 'package:indiakinursery/view/widget/cetegory/simmer/horizontal_category_simmer.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/routes.dart';
import '../../theme/app_colors.dart';
import '../../utils/assets.dart';
import '../widget/api_error/no_internet.dart';
import '../widget/common_image.dart';
import '../../controller/account_controller.dart';


class AccountPage extends GetView<AccountLogic> {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<AccountLogic>().getAccountDetails();
    return Scaffold(
      backgroundColor: AppColors.whiteColor(),
      appBar: AppBar(title: Text("Account".tr),elevation: 0,centerTitle: true),
      body: GetBuilder<AccountLogic>(
        assignId: true,
        builder: (logic) {
          return Stack(
            children: [

              Container(
                height: kToolbarHeight*2,
                color: Theme.of(context).primaryColor,
              ),

              Container(
                margin: const EdgeInsets.only(top: kToolbarHeight/2),
                width: Get.width,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor(),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                  ),
                ),
                child: (logic.noInternet) ? null : SingleChildScrollView(
                  child: Column(
                    children: [
                      25.verticalSpace,

                      if(logic.getProfile)...[

                        Shimmer.fromColors(
                          baseColor: AppColors.shimmerBaseColor(),
                          highlightColor: AppColors.shimmerHighlightColor(),
                          enabled: true,
                          child: Column(
                            children: [

                              Container(
                                width: 64.r,
                                height: 64.r,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1.r,
                                    color: AppColors.blackColor().withOpacity(0.1),
                                  ),
                                  borderRadius: BorderRadius.circular(64.r),
                                ),
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.shimmerBaseColor()
                                  ),
                                ),
                              ),

                              20.verticalSpace,

                              Text("########".toCapitalizeFirstLetter(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18.sp,
                                  letterSpacing: -1,
                                  fontFamily: "Inter",
                                  color: AppColors.textColor(),
                                ),
                              ),

                              5.verticalSpace,
                              Text("email@########",
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12.sp,
                                  fontFamily: "Inter",
                                  letterSpacing: -1,
                                  color: AppColors.darkPrimary,
                                ),
                              ),

                              20.verticalSpace,

                              Padding(
                                padding: REdgeInsets.symmetric(horizontal: 25.0),
                                child: Column(
                                  children: [
                                    ProfileMenuItem(
                                      title: "Edit Profile".tr,
                                      isShimmer: true,
                                      icon: FlutterRemix.edit_2_line,
                                    ),

                                    ProfileMenuItem(
                                      title: "Change Password".tr,
                                      isShimmer: true,
                                      icon: FlutterRemix.lock_password_line,
                                    ),

                                    ProfileMenuItem(
                                      title: "Payment History".tr,
                                      isShimmer: true,
                                      icon: FlutterRemix.secure_payment_line,
                                    ),

                                    ProfileMenuItem(
                                      title: "Order History".tr,
                                      isShimmer: true,
                                      icon: FlutterRemix.file_list_2_line,
                                    ),

                                    ProfileMenuItem(
                                      title: "Help & Support".tr,
                                      isShimmer: true,
                                      icon: FlutterRemix.file_list_2_line,
                                    ),


                                    ProfileMenuItem(
                                      title: "Logout".tr,
                                      icon: FlutterRemix.logout_circle_r_line,
                                      isLast: true,
                                      isShimmer: true,
                                      hideRightWidget: true,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )

                      ]else...[
                        Container(
                          width: 64.r,
                          height: 64.r,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.r,
                              color: AppColors.blackColor().withOpacity(0.1),
                            ),
                            borderRadius: BorderRadius.circular(64.r),
                          ),
                          child: CommonImage(
                            imageUrl: logic.userModel?.image ?? "",
                            assetPlaceholder: appUser,
                            width: 60,
                            height: 60,
                            radius: 30,
                          ),
                        ),

                        20.verticalSpace,

                        Text("${logic.userModel?.firstName ?? ""} ${logic
                            .userModel?.lastName ?? ""}".toCapitalizeFirstLetter(),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18.sp,
                            letterSpacing: -1,
                            fontFamily: "Inter",
                            color: AppColors.textColor(),
                          ),
                        ),

                        5.verticalSpace,
                        Text(logic.userModel?.email ?? "",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 12.sp,
                            fontFamily: "Inter",
                            letterSpacing: -1,
                            color: AppColors.darkPrimary,
                          ),
                        ),

                        20.verticalSpace,

                        Padding(
                          padding: REdgeInsets.symmetric(horizontal: 25.0),
                          child: Column(
                            children: [

                              ProfileMenuItem(
                                title: "Edit Profile".tr,
                                onClick: () =>
                                {
                                  Get.toNamed(rsEditProfilePage)
                                },
                                icon: FlutterRemix.edit_2_line,
                              ),

                              ProfileMenuItem(
                                title: "Change Password".tr,
                                onClick: () =>
                                {
                                  Get.toNamed(rsChangePasswordPage)
                                },
                                icon: FlutterRemix.lock_password_line,
                              ),

                              // ProfileMenuItem(
                              //   title: "Payment History".tr,
                              //   onClick: () => {
                              //
                              //   },
                              //   icon: FlutterRemix.secure_payment_line,
                              // ),

                              ProfileMenuItem(
                                title: "Order History".tr,
                                onClick: () =>
                                {
                                  Get.toNamed(rsOrderHistoryPage)
                                },
                                icon: FlutterRemix.file_list_2_line,
                              ),

                              ProfileMenuItem(
                                title: "Help & Support".tr,
                                onClick: () =>
                                {
                                  Get.toNamed(rsSupportPage)
                                },
                                icon: Icons.support_agent_outlined,
                              ),

                              ProfileMenuItem(
                                title: "Logout".tr,
                                onClick: () {
                                  controller.logout();
                                },
                                icon: FlutterRemix.logout_circle_r_line,
                                isLast: true,
                                hideRightWidget: true,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),



              if(logic.noInternet)...[
                NoInternet(
                  retry: (){
                    logic.getAccountDetails();
                  },
                ),
              ]
            ],
          );
        },
      ),
    );
  }
}
