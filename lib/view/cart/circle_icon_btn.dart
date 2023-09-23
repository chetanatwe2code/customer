import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class CircleIconBtn extends StatelessWidget {
  final double? width;
  final IconData iconData;
  final Function()? onTap;
  final Color? backgroundColor;
  final Color? iconColor;
  final double elevation;
  final bool? isLoading;

  const CircleIconBtn({
    Key? key,
    this.width,
    required this.onTap,
    required this.iconData,
    this.backgroundColor,
    this.iconColor,
    this.elevation = 0,
    this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? AppColors.primary,
      borderRadius: BorderRadius.circular(0),
      elevation: elevation,
      child: InkWell(
        borderRadius: BorderRadius.circular(0),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
              border: Border.all(
                  color: backgroundColor ?? AppColors.primary, width: 0.2)),
          alignment: Alignment.center,
          width: (width ?? 30),
          height: (width ?? 30),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              (isLoading ?? false)
                  ? Center(
                      child: SizedBox(
                        width: ((width ?? 40) / 2),
                        height: ((width ?? 40) / 2),
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.whiteColor(),
                        ),
                      ),
                    )
                  : Icon(
                          iconData,
                          size: ((width ?? 40) / 2),
                          color: iconColor ?? AppColors.text2,
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
