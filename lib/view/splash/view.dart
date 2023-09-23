import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:indiakinursery/core/di/api_client.dart';
import 'package:indiakinursery/core/di/api_provider.dart';
import 'package:indiakinursery/utils/assets.dart';

import '../../theme/app_colors.dart';
import 'logic.dart';

class SplashPage extends GetView<SplashLogic> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(kReleaseMode){
      controller.checkLogin();
    }
    return Scaffold(
      backgroundColor: AppColors.whiteColor(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(appLogo2, width: MediaQuery
                .of(context)
                .size
                .width / 2,),

            if(!kReleaseMode)...[

              40.verticalSpace,

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      Get.find<ApiClient>().updateServer(ApiProvider.baseUrl);
                      controller.isLoggedIn();
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8.0.r),
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.2),
                            borderRadius: BorderRadius.all(Radius.circular(15.r))
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 8.r,vertical: 4.r),
                        child: Text("Nursery Server",
                          style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 13.sp
                          ),),
                      ),
                    ),
                  ),
                  // InkWell(
                  //   onTap: (){
                  //     Get.find<ApiClient>().updateServer(ApiProvider.baseUrl2);
                  //     controller.isLoggedIn();
                  //   },
                  //   child: Padding(
                  //     padding: EdgeInsets.all(8.0.r),
                  //     child: Container(
                  //       decoration: BoxDecoration(
                  //           color: AppColors.darkPrimary.withOpacity(0.2),
                  //           borderRadius: BorderRadius.all(Radius.circular(15.r))
                  //       ),
                  //       padding: EdgeInsets.symmetric(horizontal: 8.r,vertical: 4.r),
                  //       child: Text("Render Server",
                  //         style: TextStyle(
                  //             color: AppColors.darkPrimary,
                  //             fontSize: 13.sp
                  //         ),),
                  //     ),
                  //   ),
                  // ),
                  InkWell(
                    onTap: (){
                      Get.find<ApiClient>().updateServer(ApiProvider.baseLocal);
                      controller.isLoggedIn();
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8.0.r),
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.secondary.withOpacity(0.2),
                            borderRadius: BorderRadius.all(Radius.circular(15.r))
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 8.r,vertical: 4.r),
                        child: Text("Local Server",
                          style: TextStyle(
                              color: AppColors.secondary,
                              fontSize: 13.sp
                          ),),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
