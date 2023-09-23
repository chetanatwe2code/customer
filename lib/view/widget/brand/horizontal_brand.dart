import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:indiakinursery/utils/assets.dart';

import '../../../core/routes.dart';
import '../../../model/BrandModel.dart';
import '../../../theme/app_colors.dart';
import '../common_image.dart';

class HorizontalBrand extends StatelessWidget {
  final BrandModel? brandModel;
  final double width;
  const HorizontalBrand({Key? key,this.brandModel,this.width = 80}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
       // Get.toNamed(rsProductPage,arguments: {"brand" : brandModel?.brand??"" });
      },
      child: Container(
        margin: EdgeInsets.only(right: 15.r),
        child: Stack(
          alignment: Alignment.center,
          children:  [

            Container(
              width: width.r,
              height: width.r,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(width.r)),
                color: Colors.black,
              ),
              child: Opacity(
                opacity: 0.3,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(width.r),
                    child: Image.asset(appCategory,fit: BoxFit.cover,width: width,height: width,)),
              ),
            ),

            Container(
              width: width.r,
              height: width.r,
              padding: EdgeInsets.all(2.r),
              child: Center(
                child: Text((brandModel?.brand??""),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.whiteColor(),
                    fontFamily: "Inter",
                    fontSize: 11.sp
                ),textAlign: TextAlign.center,),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
