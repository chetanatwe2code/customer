import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/routes.dart';
import '../../repository/sign_up_repo.dart';
import '../../utils/email_validator.dart';
import '../../utils/regex.dart';
import '../widget/toast.dart';

class SignUpLogic extends GetxController {
  final SignUpRepo signUpRepo;
  SignUpLogic({required this.signUpRepo});

  var obscureText = true.obs;
  void toggle() {
    obscureText.value = !obscureText.value;
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var signUpProcess = false.obs;
  var terms = false.obs;
  signUp({ required BuildContext context }) async{
    if(!validateLoginData()) return;
    if(!terms.value){
      Toast.show(toastMessage: "Accept all terms & conditions".tr,isError: true);
      return;
    }
    signUpProcess.value = true;
    signUpRepo.signUp({
     // "name": nameController.text,
      "email": emailController.text,
      "password": passwordController.text
    }).then((value) => {
      signUpProcess.value = false,
      if(int.tryParse(value.body['res_code']) == 001){
        /// {res_code: 001, status: ok, response: send otp on your mail, otp: 647687}
        /// go to verification page
        Get.toNamed(rsVerificationPage,
            arguments: {  'email' : emailController.text, 'otp' : value.body['otp'],"expire_time": value.body["expire_time"] }
        ),
      }else{
        Toast.show(toastMessage: "${value.body['response'] ?? "Api Failure".tr}",isError: true)
      },
      signUpProcess.value = false,
    }).catchError((e){
      signUpProcess.value = false;
      Toast.show(toastMessage: "Api Failure".tr,isError: true);
    });
  }

  validateLoginData(){
    if(emailController.text.isNotEmpty)
      if(EmailValidator.validate(emailController.text))
        if(passwordController.text.isNotEmpty)
          if(passwordController.text.length >= 4)
            return true;
          else
            Toast.show(toastMessage: "Password must be 4 characters".tr,isError: true);
        else
          Toast.show(toastMessage: "Enter Password".tr,isError: true);
      else
        Toast.show(toastMessage: "Enter Valid Email".tr,isError: true);
    else
      Toast.show(toastMessage: "Enter Email".tr,isError: true);
    return false;
  }
}
