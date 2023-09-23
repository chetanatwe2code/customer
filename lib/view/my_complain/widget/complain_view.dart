import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:indiakinursery/model/ComplainModel.dart';
import 'package:indiakinursery/utils/string_extensions.dart';

import '../../../theme/app_colors.dart';
import '../../widget/product/grid_product_view.dart';

getRightColor(String? status){
  if((status??"").endsWith("resolved")){
    return Colors.green;
  }
  return Colors.blue;
}

class ComplainView extends StatelessWidget {
  final ComplainModel? model;
  const ComplainView({Key? key,this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.whiteColor(),
        boxShadow: boxShadow(),
      ),
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text((model?.createdOn??"").toDateDMMMYY(),
              style: TextStyle(
                color: AppColors.grayColor(),
                fontSize: 12,
                fontWeight: FontWeight.w300
              ),),


              Container(
                  decoration: BoxDecoration(
                      color: (getRightColor(model?.status)).withOpacity(0.1),
                      borderRadius: const BorderRadius.all(Radius.circular(10))
                  ),
                  margin: const EdgeInsets.only(top: 2,bottom: 2),
                  padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 2),
                  child: Text((model?.status??"").toCapitalizeFirstLetter(),
                  style: TextStyle(
                    color: getRightColor(model?.status),
                  ),),),
            ],
          ),
          10.verticalSpace,
          Text((model?.subject??"").toCapitalizeFirstLetter(),
          style: const TextStyle(
              fontWeight: FontWeight.bold
          ),),
          5.verticalSpace,
          Text((model?.description??"").toCapitalizeFirstLetter()),

          if(model?.resolveDescription?.isNotEmpty??false)
            Column(
              children: [
                10.verticalSpace,
                Text("Complain Resolved".toCapitalizeFirstLetter(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold
                  ),),
                10.verticalSpace,
                Text((model?.resolveDescription??"").toCapitalizeFirstLetter()),
              ],
            ),

        ],
      ),
    );
  }
}
