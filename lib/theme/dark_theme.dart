import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

ThemeData dark() => ThemeData(
  fontFamily: 'Rubik',
  primaryColor: AppColors.primary,
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white),
    color: AppColors.primary,
    toolbarHeight: kToolbarHeight.h,
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: AppColors.primary,
    secondary: AppColors.primary,
  ),
);
