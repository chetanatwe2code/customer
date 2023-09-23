import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/routes.dart';
import '../../repository/forgot_password_repo.dart';
import '../../utils/email_validator.dart';
import '../widget/toast.dart';

class ForgotPasswordLogic extends GetxController {
  final ForgotPasswordRepo forgotPasswordRepo;
  ForgotPasswordLogic({required this.forgotPasswordRepo});

  final TextEditingController emailController = TextEditingController();

  dynamic argumentData = Get.arguments;

  @override
  void onInit() {
    emailController.text = argumentData?['email']??"";
    super.onInit();
  }

  var apiProcess = false.obs;
  forgotPassword({ required BuildContext context }) async{
    if(!kReleaseMode){
      emailController.text = "chetan.barod.we2code@gmail.com";
    }
    if(!validateLoginData()) return;
    apiProcess.value = true;
    forgotPasswordRepo.forgotPassword({
      "email": emailController.text
    }).then((value) => {
      apiProcess.value = false,
      if(value.body['status'] == true){
        Get.toNamed(rsVerificationPage,
            arguments: {  'email' : emailController.text, 'otp' : value.body['otp'] , "expire_time": value.body["expire_time"],"verify_type" : 1 }),
        Toast.show(title: "OTP sent Successfully",toastMessage: "Please check your mail"),
      }else{
        Toast.show(toastMessage: value.body['response'] ?? "Api Failure".tr,isError: true),
      },

      apiProcess.value = false,
      update(),
    }).catchError((e){
      apiProcess.value = false;
      Toast.show(toastMessage: "Api Failure".tr,isError: true);
    });
  }

  validateLoginData(){
    if(emailController.text.isNotEmpty)
      if(EmailValidator.validate(emailController.text))
          return true;
      else
        Toast.show(toastMessage: "Enter Valid Email".tr,isError: true,iconData: Icons.email);
    else
      Toast.show(toastMessage: "Enter Email".tr,isError: true,iconData: Icons.email);
    return false;
  }


}
