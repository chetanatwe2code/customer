import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:indiakinursery/utils/assets.dart';
import 'package:indiakinursery/utils/string_extensions.dart';
import 'package:indiakinursery/view/category/logic.dart';


import '../../../controller/home_controller.dart';
import '../../../core/routes.dart';
import '../../../model/CategoryModel.dart';
import '../../../theme/app_colors.dart';
import '../common_image.dart';

class HorizontalCategory extends StatelessWidget {
  final CategoryModel? categoryModel;
  final double width;
  const HorizontalCategory({Key? key,this.categoryModel,this.width=140}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(Get.isRegistered<CategoryLogic>()){
          Get.find<CategoryLogic>().selectedCategory = categoryModel;
        }
        Get.find<HomeLogic>().toIndex(1,notify: false);
        Get.offAllNamed(rsBasePage);
        //Get.toNamed(rsCategoryPage,arguments: { "category" : categoryModel?.toJson() });
      },
      child: Container(
        margin: EdgeInsets.only(right: 15.r),
        width: width,
        child: Stack(
          alignment: Alignment.center,
          children:  [

            Container(
              width: width,
              height: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                color: Colors.black,
              ),
              child: Opacity(
                opacity: 0.5,
                child: CommonImage(
                  imageUrl: categoryModel?.image,
                  assetPlaceholder: appCategory,
                  width: width,
                  fit: BoxFit.cover,
                  radius: 10,
                ),
              ),
            ),

            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text((categoryModel?.category??"").toCapitalizeFirstLetter(),
                  maxLines: 1,
                  style: TextStyle(
                    color: AppColors.whiteColor(),
                    fontFamily: "Inter"
                ),),
                // 5.verticalSpace,
                // Text((categoryModel?.categoryType??"vegetables").toCapitalizeFirstLetter(),
                //   maxLines: 1,
                //   overflow: TextOverflow.ellipsis,
                //   style: TextStyle(
                //   color: AppColors.whiteColor(),
                //   fontWeight: FontWeight.w100,
                //   fontSize: 10.sp,
                //   fontFamily: "Inter"
                // ),)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
