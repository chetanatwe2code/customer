import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indiakinursery/theme/app_colors.dart';

class StepModel{
  final String name;
  final bool isCompleted;

  StepModel({required this.name,required this.isCompleted});
}

class ShowStatus extends StatelessWidget {
  final List<StepModel> list;
  final bool orderRejected;
  final bool isSmall;
  const ShowStatus({Key? key,required this.list, this.orderRejected = false,this.isSmall = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double hPadding = isSmall ?  15 : 120;
    double lineWidth = (Get.width - (hPadding*2))/list.length;
    Color? rejectedColor = orderRejected ? AppColors.redColor() : null;
    Color? lineColor = orderRejected ? AppColors.redColor().withOpacity(0.2) : null;
    return Column(
      children: [
        Row(
          children: [
           for(int i= 0;i<list.length;i++)...[
             SizedBox(
               width: lineWidth,
               child: Row(
                 children: [
                   Expanded(
                     child: Container(
                       height: 4,
                       decoration: BoxDecoration(
                           color: lineColor ?? (list[i].isCompleted ? AppColors.primary : AppColors.primary.withOpacity(0.2)),
                       ),
                     ),
                   ),


                   Container(
                       height: 24,
                       width: 24,
                     decoration: BoxDecoration(
                       shape: BoxShape.circle,
                       color: list[i].isCompleted ? AppColors.primary : (rejectedColor ?? AppColors.primary).withOpacity(0.2),
                     ),
                       child: Center(child: Icon(
                         list[i].isCompleted ? Icons.check : Icons.close,
                         size: 15,
                         color: list[i].isCompleted ? AppColors.whiteColor() : (rejectedColor ?? AppColors.primary).withOpacity(0.8),
                       ))
                   ),

                   Expanded(
                     child: Container(
                       height: 4,
                       decoration: BoxDecoration(
                           color: lineColor ?? (list[i].isCompleted ? AppColors.primary : AppColors.primary.withOpacity(0.2)),
                       ),
                     ),
                   ),


                 ],
               ),
             )
           ],
          ],
        ),

        SizedBox(height: 10,),

        Row(
          children: [
            for(int i= 0;i<list.length;i++)...[
              SizedBox(
                width: lineWidth,
                child: Center(child: Text(
                  list[i].name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: list[i].isCompleted ? AppColors.primary : AppColors.textColor(),
                      fontWeight: FontWeight.bold,
                  ),
                )),
              )
            ],
          ],
        ),
      ],
    );
  }
}
