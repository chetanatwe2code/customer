import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/app_colors.dart';

class ProfileMenuItem extends StatelessWidget {
  final String? title;
  final Function()? onClick;
  final IconData? icon;
  final Widget? rightWidget;
  final bool hideRightWidget;
  final bool isLast;
  final bool isWarning;
  final double hPadding;
  final bool isShimmer;
  final bool isSmall;

  const ProfileMenuItem({
    Key? key,
    this.title,
    this.onClick,
    this.icon,
    this.rightWidget,
    this.hPadding = 0.0,
    this.isLast = false,
    this.hideRightWidget = false,
    this.isShimmer = false,
    this.isWarning = false,
    this.isSmall = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hPadding),
      child: Material(
        color: isShimmer ? Colors.grey.withOpacity(0.1) : AppColors.whiteColor(),
        child: InkWell(
          onTap: isShimmer ? null : onClick,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 34,
                          width: 34,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.darkPrimary.withOpacity(0.1)
                          ),
                          child: Icon(
                            icon,
                            size: 20,
                            color: isWarning
                                ? AppColors.redColor()
                                : AppColors.darkPrimary,
                          ),
                        ),
                        10.horizontalSpace,
                        Flexible(
                          child: Text(
                            '$title',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.4,
                              color: isWarning
                                  ? AppColors.redColor()
                                  : AppColors.textColor(),
                              fontSize: isSmall ? 13.sp : 10.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if(!hideRightWidget)
                  if (rightWidget != null) rightWidget!
                  else const Icon(Icons.arrow_forward_ios,size: 20,color: AppColors.darkPrimary,)
                ],
              ),
              20.verticalSpace,
              if (!isLast)
                Divider(
                  height: 1.r,
                  thickness: 1.r,
                  color: AppColors.grayColor().withOpacity(0.3),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
