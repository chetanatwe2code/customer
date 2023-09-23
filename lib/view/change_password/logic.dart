import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/routes.dart';
import '../../repository/change_password_repo.dart';
import '../../utils/regex.dart';
import '../widget/toast.dart';

class ChangePasswordLogic extends GetxController {
  final ChangePasswordRepo changePasswordRepo;
  ChangePasswordLogic({required this.changePasswordRepo});

  dynamic argumentData = Get.arguments;

  /// is_forgot
  ///  0 = change password , 1 = forgot password
  bool isForgot = false;
  String? token;

  @override
  void onInit() {
    isForgot = (int.tryParse((argumentData?['is_forgot'] ?? 0).toString())??0) == 1;
    if(isForgot){
      token = argumentData?['token'];
    }
    super.onInit();
    update();
  }

  var obscureText = true.obs;
  var obscure2Text = true.obs;
  void toggle() {
    obscureText.value = !obscureText.value;
  }
  void toggle2() {
    obscure2Text.value = !obscure2Text.value;
  }
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  var apiProcess = false.obs;
  changePassword({ required BuildContext context }) async{
    if(!validateLoginData()) return;
    apiProcess.value = true;
    update();
    if(!isForgot){
      token = changePasswordRepo.getToken();
    }
    changePasswordRepo.changePassword({"password": passwordController.text}, token).then((value) => {
      apiProcess.value = false,
      update(),
      if(value.body['success'] == true){
        if(isForgot){
          Toast.show(toastMessage: "Password Successfully changed".tr),
          Get.offAllNamed(rsLoginPage),
        }else{
          Get.back(),
          Toast.show(toastMessage: "Password Successfully changed".tr),
        }
      }else{
        Toast.show(toastMessage: "Try Again".tr),
      },
    }).catchError((e){
      apiProcess.value = false;
      Toast.show(toastMessage: "Try Again".tr);
      update();
    });
  }

  validateLoginData(){
    if(passwordController.text.isNotEmpty)
      if(passwordController.text.length >= 4)
        if(confirmPasswordController.text.isNotEmpty)
          if(confirmPasswordController.text.endsWith(passwordController.text))
            return true;
          else
            Toast.show(toastMessage: "Password and Confirm Password Mismatched".tr,isError: true);
        else
          Toast.show(toastMessage: "Enter Confirm Password".tr,isError: true);
      else
        Toast.show(toastMessage: "Password must be 4 characters".tr,isError: true);
    else
      Toast.show(toastMessage: "Please Enter Password".tr,isError: true);

    return false;
  }
}
