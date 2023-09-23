import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/app_colors.dart';

class NotFound extends StatelessWidget {
  final double? height;
  final Function? retry;
  const NotFound({Key? key,this.height,this.retry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off,
              size: 50,color: AppColors.textColor(),),
            10.verticalSpace,
            Text("No Data Found",style: TextStyle(
                color: AppColors.textColor(),
                fontSize: 15.r,
                fontWeight: FontWeight.w300
            ),),

            30.verticalSpace,

            if(retry != null)
              ElevatedButton(onPressed: (){
                retry!();
              }, child: const Text("Re-try"))
          ],
        ),
      ),
    );
  }
}
