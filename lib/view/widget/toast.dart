import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/app_colors.dart';


class Toast {


  static void show({String? title,
    String toastMessage = "",
    bool isError = false,
    IconData? iconData,
    Color? backgroundColor}) {

    Get.snackbar(
        title??"",
        titleText: title == null ? const SizedBox() : null,
        backgroundColor: isError ? AppColors.redColor() : backgroundColor ?? AppColors.darkPrimary,
        borderRadius: 0,
        barBlur: 10,
        icon: iconData != null ? Icon(iconData,color: Colors.white,) : null,
        colorText: Colors.white,
        toastMessage,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(0)
    );

  }
}
