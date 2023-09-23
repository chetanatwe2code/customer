import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/routes.dart';
import '../../repository/verification_repo.dart';
import '../widget/otp_view.dart';
import '../widget/toast.dart';

class VerificationLogic extends GetxController {
  final VerificationRepo verificationRepo;
  VerificationLogic({required this.verificationRepo});

  dynamic argumentData = Get.arguments;
  final TextEditingController emailController = TextEditingController();
  GlobalKey<OtpViewState> otpKey = GlobalKey<OtpViewState>();

  List<int> otpString = [ -1 , -1 , -1 , -1 , -1 , -1];
  var time = 0.obs;
  getTime(){
    return "${time.value}";
  }
  String getOtp(){
    String otp = "";
    for(int h =  0 ; h < otpString.length ; h ++ ){
      if(otpString[h] != -1){
        otp = otp + otpString[h].toString();
      }
    }
    return otp;
  }

  var resentOtpProgress = false.obs;
  resentOtp(){
    resentOtpProgress.value = true;
    update();
    otpKey.currentState?.refreshData();
    verificationRepo.resentOtp({"email": emailController.text},verifyType==1).then((value) => {
      resentOtpProgress.value = false,
      if(value.body['status']){
        //value.body['otp'],
        time.value = int.parse("${value.body['expire_time']??59}"),
        Toast.show(title: "OTP sent Successfully",toastMessage: "Please check your mail"),
        startTimer(),
      }else{
        Toast.show(toastMessage: "Api Failure".tr,isError: true),
      },

      resentOtpProgress.value = false,
      update(),
    }).catchError((e){
      resentOtpProgress.value = false;
      Toast.show(toastMessage: "OTP Send Failed".tr,isError: true);
    });
  }

  bool removeAndAdd(int index , String s){
    index -= index;
    if(s.isNotEmpty){
      otpString[index] = int.parse(s);
      return true;
    }else{
      otpString[index] = -1;
      return false;
    }
  }

  /// 0 = from sign-up, 1 = forgot password
  int verifyType = 0;

  @override
  void onInit() {
     time.value = int.parse("${argumentData?['expire_time']??59}");
     emailController.text = argumentData?['email']??"";
     verifyType = int.tryParse((argumentData?['verify_type'] ?? 0).toString())??0;
    super.onInit();
    update();
    startTimer();
  }

  Timer? _timer;
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec,
          (Timer timer) {
        if (time.value == 0) {
          timer.cancel();
        } else {
          time.value--;
        }
      },
    );
  }

  //
  var verifyProcess = false.obs;
  verifyEmail(BuildContext context) async{
    print("VeriFY_OTP ${getOtp()}");
    if(!validateLoginData()) return;
    verifyProcess.value = true;

    verificationRepo.verifyEmail({ 'email' : emailController.text, 'otp' : getOtp() }).then((value) => {
      if((value.body['status'] ?? false) || (value.body['success'] ?? false)){
        if(verifyType==1){
          Get.offNamed(rsChangePasswordPage,arguments: { 'token' : value.body['token'] , 'is_forgot' : 1 })
        }else{
          verificationRepo.saveLoginData(value.body['token']),
          Get.offAllNamed(rsBasePage)
        }
      }else{
        Toast.show(toastMessage: "OTP not matched",isError: true),
      },
     verifyProcess.value = false,
     update()
    }).catchError((e){
      verifyProcess.value = false;
      Toast.show(toastMessage: "Verification Failed",isError: true);
    });
  }

  validateLoginData(){
    if(!otpString.contains(-1)) {
      return true;
    } else {
      Toast.show(toastMessage: "Please Enter Valid OTP",isError: true);
      return false;
    }
  }


}
