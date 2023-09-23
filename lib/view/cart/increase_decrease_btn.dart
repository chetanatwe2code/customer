import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import '../../theme/app_colors.dart';
import '../widget/circle_icon_button.dart';
import 'circle_icon_btn.dart';

class IncreaseDecreaseBtn extends StatelessWidget {
  final Function()? onDecrease;
  final bool? isDecrease;
  final Function()? onIncrease;
  final bool? isIncrease;
  final double buttonSize;
  final int? cartCount;

  const IncreaseDecreaseBtn({
    Key? key,
    required this.onDecrease,
    this.isDecrease = false,
    required this.onIncrease,
    this.isIncrease = false,
    this.buttonSize = 30,
    this.cartCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        CircleIconBtn(
          onTap: onIncrease,
          iconData: FlutterRemix.add_line,
          width: buttonSize,
          isLoading: isIncrease ?? false,
          iconColor: AppColors.whiteColor(),
          backgroundColor: Colors.green,
        ),

        /// when i wrap Container in expanded then it is not working some time
        Flexible(
          fit: FlexFit.loose,
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.whiteColor(),
                border: Border(top: BorderSide(color: AppColors.text2,width: 0.2),
                    bottom: BorderSide(color: AppColors.text2,width: 0.2))
            ),
            height: (buttonSize),
            width: buttonSize,
            child: Center(
              child: Text('${cartCount ?? 0}',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: buttonSize/2,
                  color: AppColors.textColor(),
                ),
              ),
            ),
          ),
        ),

        CircleIconBtn(
          onTap: onDecrease,
          iconData: FlutterRemix.subtract_line,
          width: buttonSize,
          isLoading: (isDecrease ?? false),
          iconColor: Colors.white,
          backgroundColor: AppColors.text2.withOpacity(0.3),
        ),
      ],
    );
  }
}
