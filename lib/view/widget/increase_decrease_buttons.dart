import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import '../../theme/app_colors.dart';
import 'circle_icon_button.dart';

class IncreaseDecreaseButtons extends StatelessWidget {
  final Function()? onDecrease;
  final bool? isDecrease;
  final Function()? onIncrease;
  final bool? isIncrease;
  final double buttonSize;
  final int? cartCount;

  const IncreaseDecreaseButtons({
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
        if(isDecrease ?? false)...[
           SizedBox(
               width: (buttonSize),
               height: (buttonSize),
              child: CircularProgressIndicator(strokeWidth: 1,)),
        ]else...[
          CircleIconButton(
            onTap: onDecrease,
            iconData: FlutterRemix.subtract_line,
            width: buttonSize,
            iconColor: Colors.red,
            backgroundColor: Colors.red.withOpacity(0.15),
          ),
        ],
        SizedBox(width: 4,),
        /// when i wrap Container in expanded then it is not working some time
        Flexible(
          fit: FlexFit.loose,
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.primary,
              borderRadius: BorderRadius.all(Radius.circular(4))
            ),
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: (buttonSize),
            child: Center(
              child: RichText(
                text: TextSpan(
                  text: '${cartCount ?? 0}',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: buttonSize/2,
                    color: AppColors.whiteColor(),
                    letterSpacing: -0.4,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text:
                      '',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                        color: AppColors.whiteColor(),
                        letterSpacing: -0.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 4,),
        if((isIncrease ?? false))...[
          SizedBox(
              width: (buttonSize),
              height: (buttonSize),
              child: CircularProgressIndicator(strokeWidth: 1,)),
        ]else...[
          CircleIconButton(
            onTap: onIncrease,
            iconData: FlutterRemix.add_line,
            width: buttonSize,
            iconColor: Colors.green,
            backgroundColor: Colors.green.withOpacity(0.15),
          ),
        ],
      ],
    );
  }
}
