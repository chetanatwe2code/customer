import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/di/api_client.dart';
import '../core/di/api_provider.dart';
import '../core/routes.dart';
import '../model/UserModel.dart';
import '../view/widget/toast.dart';

class AccountLogic extends GetxController implements GetxService{
  // final AccountRepo accountRepo;
  // AccountLogic({required this.accountRepo});
  final ApiClient apiClient;
  AccountLogic({required this.apiClient});



 Future<void> logout() async{
    await apiClient.sharedPreferences.remove(ApiProvider.preferencesToken);
    //await FirebaseMessaging.instance.deleteToken();
    Get.offAllNamed(rsLoginPage);
  }

  UserModel? userModel;
  bool noInternet = false;
  bool getProfile = false;
  Future<void> getAccountDetails()async {
    getProfile = true;
   // update();
    await apiClient.getAPI(ApiProvider.userDetails).then((value) => {
       userModel = UserModel.fromJson(value.body[0]),
      print("logic.userModel?.image ${userModel}")
     },onError: (e){
      if(e.message == ApiClient.noInternetMessage){
        noInternet = true;
      }
      Toast.show(isError: true,toastMessage: e.message);
    }).whenComplete(() => {
      noInternet = false,
      getProfile = false,
      update()
    });
 }

  setFCMToken({ required String token }) async {
    await apiClient.putAPI(ApiProvider.setNotificationToken,{ "token" : token }).then((value) => {
      print("FCM_UPDATE e ${value.body}")
    },onError: (e){
      print("FCM_UPDATE e $e");
    }).catchError((e){
      print("FCM_UPDATE e1 $e");
    });
  }


  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
 // final TextEditingController address2Controller = TextEditingController();
  var updateProcess = false.obs;

  initData(){
    firstNameController.text = userModel?.firstName??"";
    lastNameController.text = userModel?.lastName??"";
    numberController.text = userModel?.phoneNo??"";
    pinCodeController.text = userModel?.pincode??"";
    cityController.text = userModel?.city??"";
    addressController.text = userModel?.address??"";
   // address2Controller.text = userModel?.alternateAddress??"";
  }

  updateUser(File? file) async{
    if(validateLoginData()) return;

    dynamic body = {};
    if(file != null){
      body = {
        'image': MultipartFile(file, filename: 'user_image.jpg'),
        "first_name":firstNameController.text,
        "last_name":lastNameController.text,
        "phone_no":numberController.text,
        "pincode":pinCodeController.text,
        "city":cityController.text,
        "address":addressController.text,
       // "alternate_address":address2Controller.text
      };
    }else{
      body = {
        "first_name":firstNameController.text,
        "last_name":lastNameController.text,
        "phone_no":numberController.text,
        "pincode":pinCodeController.text,
        "city":cityController.text,
        "address":addressController.text,
        //"alternate_address":address2Controller.text
      };
    }

    FormData formData = FormData(body);
    print("sdssdssddsd ${formData.boundary}");

   // return;
    updateProcess.value = true;
    update();

    await apiClient.putAPI(ApiProvider.userUpdate, formData).then((value) => {
      updateProcess.value = false,
      if(value.body['status'] == true){
        Get.back(),
        Toast.show(toastMessage: "Your profile has been updated",iconData: Icons.check_circle),
        getAccountDetails(),

      }else{
        Toast.show(toastMessage: "Api Failure".tr,isError: true),
        updateProcess.value = false,
        update(),
      },
    }).catchError((e){
      Toast.show(toastMessage: "Api Failure".tr,isError: true);
    }).whenComplete(() => {
    updateProcess.value = false,
      update()
    });
 }

  validateLoginData(){
    if(firstNameController.text.isNotEmpty)
      if(numberController.text.isEmpty || (numberController.text.length == 10))
        if(pinCodeController.text.isEmpty || pinCodeController.text.length == 6)
        return false;
        else
          Toast.show(toastMessage: "Enter valid pincode",isError: true);
      else
        Toast.show(toastMessage: "Enter valid number",isError: true);
    else
      Toast.show(toastMessage: "First Name Empty",isError: true);

    return true;

  }
}
